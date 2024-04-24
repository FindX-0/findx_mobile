import 'package:collection/collection.dart';
import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../features/authentication/api/auth_user_info_provider.dart';
import '../../../shared/logger.dart';
import '../api/math_battle_result_changed_channel.dart';
import '../model/math_battle_result.dart';
import '../model/two_player_math_battle_results.dart';
import '../util/math_battle_result_mapper.dart';

final class MathBattleResultCubitArgs {
  MathBattleResultCubitArgs({
    required this.matchId,
  });

  final String matchId;
}

extension MathBattleResultCubitX on BuildContext {
  MathBattleResultCubit get mathBattleResultCubit => read<MathBattleResultCubit>();
}

typedef MathBattleResultState = SimpleDataState<TwoPlayerMathBattleResults>;

@injectable
class MathBattleResultCubit extends Cubit<MathBattleResultState> {
  MathBattleResultCubit(
    this._mathBattleResultChangedChannel,
    this._mathBattleResultRemoteRepository,
    this._authUserInfoProvider,
    this._mathBattleResultMapper,
    this._pageNavigator,
  ) : super(MathBattleResultState.idle());

  final MathBattleResultChangedChannel _mathBattleResultChangedChannel;
  final MathBattleResultRemoteRepository _mathBattleResultRemoteRepository;
  final AuthUserInfoProvider _authUserInfoProvider;
  final MathBattleResultMapper _mathBattleResultMapper;
  final PageNavigator _pageNavigator;

  final _subscriptions = SubscriptionComposite();

  Future<void> init(MathBattleResultCubitArgs args) async {
    emit(SimpleDataState.loading());

    final results = await _mathBattleResultRemoteRepository.getByMatchId(matchId: args.matchId);

    await results.ifRight(
      (r) async {
        final results = await _resolveFromResults(r);
        if (results == null) {
          logger.w('Failed to resolve results from $r');
        }

        emit(SimpleDataState.success(results!));
      },
    );

    _subscriptions.add(_mathBattleResultChangedChannel.events.listen(_onMathBattleResultsChanged));
  }

  @override
  Future<void> close() async {
    await _subscriptions.closeAll();

    return super.close();
  }

  Future<TwoPlayerMathBattleResults?> _resolveFromResults(List<GetMathBattleResultsRes> results) async {
    final authUserId = await _authUserInfoProvider.getId();
    if (authUserId == null) {
      return null;
    }

    final myResult = results.firstWhereOrNull((r) => r.userId == authUserId);
    final opponentRes = results.firstWhereOrNull((r) => r.userId != authUserId);

    if (myResult == null || opponentRes == null) {
      return null;
    }

    return TwoPlayerMathBattleResults(
      myResult: myResult,
      opponentRes: opponentRes,
    );
  }

  Future<void> _onMathBattleResultsChanged(List<MathBattleResult> event) async {
    final newState = await state.map((data) async {
      final results = event.map(_mathBattleResultMapper.dtoToGqlModel).toList();

      return _resolveFromResults(results);
    });

    emit(newState);
  }

  void onOkPressed() {
    _pageNavigator.popTillMain();
  }
}
