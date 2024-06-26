import 'dart:async';

import 'package:collection/collection.dart';
import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../entities/math_battle_score/api/math_battle_score_changed_channel.dart';
import '../../../entities/math_battle_score/model/math_battle_score_changed.dart';
import '../../../pages/match_result_page.dart';
import '../../../shared/app_environment.dart';
import '../../../shared/logger.dart';
import '../../../shared/ui/toast/toast_notifier.dart';
import '../../authentication/api/auth_user_info_provider.dart';
import '../../server_time/api/get_server_time.dart';

part 'math_battle_state.freezed.dart';

@freezed
class MathBattleState with _$MathBattleState {
  const factory MathBattleState({
    required SimpleDataState<GetMathBattleDataAuthUserRes> authUser,
    required SimpleDataState<GetMathBattleDataOpponentUserRes> opponentUser,
    required int authUserScore,
    required int opponentUserScore,
    required SimpleDataState<List<GetMathBattleDataMathProblemItem>> mathProblems,
    required int currentMathProblemIndex,
    required bool noMoreMathProblems,
    GetMathBattleDataMathProblemItem? currentMathProblem,
    DateTime? matchEndsAt,
    DateTime? matchStartsAt,
    Duration? matchEndsIn,
    Duration? countdownLeft,
    required bool isCountdownFinished,
    Duration? spamClickDelayLeft,
  }) = _MathBattleState;

  factory MathBattleState.initial() => MathBattleState(
        authUser: SimpleDataState.idle(),
        opponentUser: SimpleDataState.idle(),
        authUserScore: 0,
        opponentUserScore: 0,
        currentMathProblemIndex: 0,
        mathProblems: SimpleDataState.idle(),
        noMoreMathProblems: false,
        isCountdownFinished: false,
      );
}

extension MathBattleCubitX on BuildContext {
  MathBattleCubit get mathBattleCubit => read<MathBattleCubit>();
}

@injectable
class MathBattleCubit extends Cubit<MathBattleState> {
  MathBattleCubit(
    this._mathBattleRemoteRepository,
    this._matchmakingRemoteRepository,
    this._authUserInfoProvider,
    this._mathBattleScoreChangedChannel,
    this._getServerTime,
    this._toastNotifier,
    this._pageNavigator,
  ) : super(MathBattleState.initial());

  final MathBattleRemoteRepository _mathBattleRemoteRepository;
  final MatchmakingRemoteRepository _matchmakingRemoteRepository;
  final AuthUserInfoProvider _authUserInfoProvider;
  final MathBattleScoreChangedChannel _mathBattleScoreChangedChannel;
  final GetServerTime _getServerTime;
  final ToastNotifier _toastNotifier;
  final PageNavigator _pageNavigator;

  String? _matchId;
  Timer? _timer;

  final _subscriptions = SubscriptionComposite();
  final List<int> _recentAnswerSubmitTimestampMillis = [];

  MathBattleData? _mathBattleData;

  Future<void> init({
    required String matchId,
  }) async {
    _matchId = matchId;

    _initChannelListeners();

    await _fetchMathBattleData();
  }

  @override
  Future<void> close() async {
    await _subscriptions.closeAll();
    _timer?.cancel();

    return super.close();
  }

  Future<void> submitAnswer(String answer) async {
    if (_matchId == null) {
      logger.wtf("submitAnswer, _matchId is null, can't submit answer");
      return;
    }

    if (_mathBattleData == null) {
      logger.wtf("submitAnswer, _mathBattleData is null, can't submit answer");
      return;
    }

    if (state.currentMathProblem == null) {
      logger.wtf("submitAnswer, state.currentMathProblem is null, can't submit answer");
      return;
    }

    if (_recentAnswerSubmitTimestampMillis.length >= 4) {
      final lastFourTimestamps =
          _recentAnswerSubmitTimestampMillis.sublist(_recentAnswerSubmitTimestampMillis.length - 4);

      final firstTimeDiff = lastFourTimestamps[3] - lastFourTimestamps[2];
      final secondTimeDiff = lastFourTimestamps[2] - lastFourTimestamps[1];
      final thirdTimeDiff = lastFourTimestamps[1] - lastFourTimestamps[0];

      logger
          .d('firstTimeDiff: $firstTimeDiff, secondTimeDiff: $secondTimeDiff, thirdTimeDiff: $thirdTimeDiff');

      final makedAsSpamClick = [firstTimeDiff, secondTimeDiff, thirdTimeDiff]
          .every((e) => e < AppEnvironment.spamClickThresholdMillis);

      logger.d(
          'makedAsSpamClick: $makedAsSpamClick, spamDelayMillis: ${_mathBattleData!.mathField.spamDelayMillis}');

      if (makedAsSpamClick) {
        emit(state.copyWith(
          spamClickDelayLeft: Duration(milliseconds: _mathBattleData!.mathField.spamDelayMillis),
        ));

        _recentAnswerSubmitTimestampMillis.clear();
        return;
      }
    }

    final serverTime = await _getServerTime();

    _recentAnswerSubmitTimestampMillis.add(serverTime.millisecondsSinceEpoch);

    final submitRes = await _mathBattleRemoteRepository.submitMathProblemAnswer(
      matchId: _matchId!,
      mathProblemId: state.currentMathProblem!.id,
      answer: answer,
    );

    if (submitRes.isLeft) {
      _toastNotifier.notify(message: (l) => l.couldnotSubmitAnswer, title: (l) => l.error);
      return;
    }

    final nextMathProblemIndex = state.currentMathProblemIndex + 1;
    final mathProblemsCount = state.mathProblems.ifData(
      (data) => data.length,
      orElse: () => 0,
    );

    if (nextMathProblemIndex >= mathProblemsCount) {
      emit(state.copyWith(noMoreMathProblems: true));
      return;
    }

    final nextMathProblem = state.mathProblems.ifData(
      (data) => data.elementAtOrNull(nextMathProblemIndex),
      orElse: () => null,
    );

    emit(state.copyWith(
      currentMathProblemIndex: nextMathProblemIndex,
      currentMathProblem: nextMathProblem,
    ));
  }

  Future<void> _fetchMathBattleData() async {
    if (_matchId == null) {
      logger.wtf("_fetchMathProblems, _matchId is null, can't fetch math problems");
      return;
    }

    final authUserId = await _authUserInfoProvider.getId();
    if (authUserId == null) {
      logger.w('_fetchMathProblems, auth user id is null, returning');
      return;
    }

    emit(state.copyWith(mathProblems: SimpleDataState.loading()));
    final match = await _matchmakingRemoteRepository.getMatchById(_matchId!);

    if (match.isLeft) {
      logger.i("_fetchMathProblems, couldn't fetch match, $match returning");
      _emitDataFailures();
      return;
    }

    _initTimer(match.rightOrThrow);

    final opponentUserId = match.rightOrThrow.userIds.where((e) => e != authUserId).firstOrNull;
    if (opponentUserId == null) {
      logger.wtf('_fetchMathProblems, opponentUserId is null, returning');
      _emitDataFailures();
      return;
    }

    final data = await _mathBattleRemoteRepository.getMathBattleData(
      matchId: _matchId!,
      opponentUserId: opponentUserId,
    );

    data.fold(
      (_) => _emitDataFailures(),
      (r) {
        _mathBattleData = r;

        emit(state.copyWith(
          currentMathProblem: r.mathProblems.firstOrNull,
          mathProblems: SimpleDataState.success(List.of(r.mathProblems)),
          authUser: SimpleDataState.success(r.authUser),
          opponentUser: SimpleDataState.success(r.opponentUser),
        ));
      },
    );
  }

  void _initChannelListeners() {
    _subscriptions.add(
      _mathBattleScoreChangedChannel.events.listen(_onMathBattleScoreChanged),
    );
    _mathBattleScoreChangedChannel.startListening();
  }

  void _initTimer(GetMatchByIdRes match) {
    const timerInterval = Duration(milliseconds: 250);

    _timer?.cancel();
    _timer = Timer.periodic(
      timerInterval,
      (_) async {
        final serverTime = await _getServerTime();

        final durationLeftTillStartAt = match.startAt.difference(serverTime);
        final durationLeftTillEndAt = match.endAt.difference(serverTime);

        // cases:
        // * didn't pass startAt (isn't negative) -> null
        // * did pass start at and didn't pass endAt -> duration of difference
        // * else both are passed and set to Duration.zero
        final matchEndsIn = !durationLeftTillStartAt.isNegative
            ? null
            : durationLeftTillStartAt.isNegative && !durationLeftTillEndAt.isNegative
                ? durationLeftTillEndAt
                : Duration.zero;

        final countdownLeft = durationLeftTillStartAt.isNegative ? null : durationLeftTillStartAt;
        final newSpamClickDelayLeft =
            state.spamClickDelayLeft != null ? state.spamClickDelayLeft! - timerInterval : null;

        emit(state.copyWith(
          matchEndsIn: matchEndsIn,
          countdownLeft: countdownLeft,
          isCountdownFinished: durationLeftTillStartAt.isNegative,
          spamClickDelayLeft: newSpamClickDelayLeft == null || newSpamClickDelayLeft.isNegative
              ? null
              : newSpamClickDelayLeft,
        ));

        final matchEnded = durationLeftTillEndAt.isNegative || durationLeftTillEndAt == Duration.zero;
        if (matchEnded) {
          if (_matchId == null) {
            logger.wtf("_matchId is null, cann't navigate to match result page");
            return;
          }

          final args = MatchResultPageArgs(matchId: _matchId!);

          _pageNavigator.toMatchResult(args);
          _timer?.cancel();
        }
      },
    );
  }

  void _emitDataFailures() {
    emit(state.copyWith(
      mathProblems: SimpleDataState.failure(),
      authUser: SimpleDataState.failure(),
      opponentUser: SimpleDataState.failure(),
    ));
  }

  Future<void> _onMathBattleScoreChanged(MathBattleScoreChanged payload) async {
    if (_matchId != payload.matchId) {
      logger.wtf("_onMathBattleScoreChanged, matchIds don't match");
      return;
    }

    final authUserId = await _authUserInfoProvider.getId();
    if (authUserId == null) {
      logger.wtf('_onMathBattleScoreChanged, authUserId is null');
      return;
    }

    final opponentUserScore = payload.scores.firstWhereOrNull((e) => e.userId != authUserId);
    final authUserScore = payload.scores.firstWhereOrNull((element) => element.userId == authUserId);

    if (opponentUserScore == null || authUserScore == null) {
      logger.w('_onMathBattleScoreChanged, opponent user score or auth user score is null');
      return;
    }

    emit(state.copyWith(
      authUserScore: authUserScore.score,
      opponentUserScore: opponentUserScore.score,
    ));
  }
}
