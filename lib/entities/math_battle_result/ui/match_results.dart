import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/intl/app_localizations.dart';
import '../model/two_player_math_battle_results.dart';
import '../state/math_battle_result_state.dart';

class MatchResults extends StatelessWidget {
  const MatchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return BlocBuilder<MathBattleResultCubit, MathBattleResultState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          success: (data) => Column(
            children: [
              const Spacer(flex: 4),
              _AvatarsWithScores(results: data),
              const Spacer(flex: 2),
              Text(_statusLabel(l, data.myResult)),
              const Spacer(),
              TextButton(
                onPressed: context.mathBattleResultCubit.onOkPressed,
                child: Text(l.ok),
              ),
              const Spacer(flex: 4),
            ],
          ),
        );
      },
    );
  }

  String _statusLabel(AppLocalizations l, GetMathBattleResultsRes result) {
    if (result.isDraw) {
      return l.draw;
    }

    if (result.isWinner) {
      return l.youWon;
    }

    return l.youLost;
  }
}

class _AvatarsWithScores extends StatelessWidget {
  const _AvatarsWithScores({
    required this.results,
  });

  final TwoPlayerMathBattleResults results;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _playerAvatarWithScore(results.myResult),
        _playerAvatarWithScore(results.opponentRes),
      ],
    );
  }

  Widget _playerAvatarWithScore(GetMathBattleResultsRes result) {
    final scoreStr = result.score.toStringAsFixed(0);

    return Column(
      children: [
        Text('User ${result.userId}'),
        Text('Score $scoreStr'),
      ],
    );
  }
}
