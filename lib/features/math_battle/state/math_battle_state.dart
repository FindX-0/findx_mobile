import 'package:common_models/common_models.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/logger.dart';
import '../../../shared/ui/toast/toast_notifier.dart';
import '../../authentication/api/auth_user_info_provider.dart';

part 'math_battle_state.freezed.dart';

@freezed
class MathBattleState with _$MathBattleState {
  const factory MathBattleState({
    required SimpleDataState<User> authUser,
    required SimpleDataState<User> opponentUser,
    required SimpleDataState<List<GetMathBattleDataMathProblemItem>> mathProblems,
    required int currentMathProblemIndex,
    GetMathBattleDataMathProblemItem? currentMathProblem,
  }) = _MathBattleState;

  factory MathBattleState.initial() => MathBattleState(
        authUser: SimpleDataState.idle(),
        opponentUser: SimpleDataState.idle(),
        currentMathProblemIndex: 0,
        mathProblems: SimpleDataState.idle(),
      );
}

@injectable
class MathBattleCubit extends Cubit<MathBattleState> {
  MathBattleCubit(
    this._mathBattleRemoteRepository,
    this._matchmakingRemoteRepository,
    this._authUserInfoProvider,
    this._toastNotifier,
  ) : super(MathBattleState.initial());

  final MathBattleRemoteRepository _mathBattleRemoteRepository;
  final MatchmakingRemoteRepository _matchmakingRemoteRepository;
  final AuthUserInfoProvider _authUserInfoProvider;
  final ToastNotifier _toastNotifier;

  String? _matchId;

  Future<void> init({
    required String matchId,
  }) async {
    _matchId = matchId;

    await _fetchMathBattleData();
  }

  Future<void> submitAnswer(String answer) async {
    if (_matchId == null) {
      logger.wtf("submitAnswer, _matchId is null, can't submit answer");
      return;
    }

    if (state.currentMathProblem == null) {
      logger.wtf("submitAnswer, state.currentMathProblem is null, can't submit answer");
      return;
    }

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
    final nextMathProblem = state.mathProblems.maybeWhen(
      orElse: () => null,
      success: (data) => data[nextMathProblemIndex],
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
        final firstMathProblem = r.mathProblems.firstOrNull;

        emit(state.copyWith(
          currentMathProblem: firstMathProblem,
          mathProblems: SimpleDataState.success(r.mathProblems),
          authUser: SimpleDataState.success(r.authUser),
          opponentUser: SimpleDataState.success(r.opponentUser),
        ));
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
}
