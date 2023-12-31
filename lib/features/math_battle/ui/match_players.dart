import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/math_battle_state.dart';

class MatchPlayers extends StatelessWidget {
  const MatchPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final spacing = (constraints.maxWidth - 16 * 2) * .05;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: BlocBuilder<MathBattleCubit, MathBattleState>(
                buildWhen: (previous, current) =>
                    previous.authUser != current.authUser || previous.authUserScore != current.authUserScore,
                builder: (_, state) {
                  return _PlayerContainer(
                    reverse: false,
                    username: state.authUser.getOrNull?.userName ?? '',
                    score: state.authUserScore.toString(),
                  );
                },
              ),
            ),
            SizedBox(width: spacing * 2),
            Expanded(
              child: BlocBuilder<MathBattleCubit, MathBattleState>(
                buildWhen: (previous, current) =>
                    previous.opponentUser != current.opponentUser ||
                    previous.opponentUserScore != current.opponentUserScore,
                builder: (_, state) {
                  return _PlayerContainer(
                    reverse: true,
                    username: state.opponentUser.getOrNull?.userName ?? '',
                    score: state.opponentUserScore.toString(),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PlayerContainer extends StatelessWidget {
  const _PlayerContainer({
    required this.reverse,
    required this.username,
    required this.score,
  });

  final String username;
  final String score;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final children = [
      CircleAvatar(
        backgroundColor: theme.colorScheme.primary,
        radius: 15,
      ),
      const SizedBox(width: 5),
      Expanded(
        child: Text(
          username,
          maxLines: 1,
          textAlign: reverse ? TextAlign.right : null,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      const SizedBox(width: 6),
      Text(
        score,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.colorScheme.primaryContainer,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: reverse ? children.reversed.toList() : children,
      ),
    );
  }
}
