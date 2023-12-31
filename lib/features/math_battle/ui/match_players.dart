import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        radius: 15.r,
      ),
      SizedBox(width: 5.w),
      Expanded(
        child: Text(
          username,
          maxLines: 1,
          textAlign: reverse ? TextAlign.right : null,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
      ),
      SizedBox(width: 6.w),
      Text(
        score,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: theme.colorScheme.primaryContainer,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 6.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: reverse ? children.reversed.toList() : children,
      ),
    );
  }
}
