import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/util/format/duration.dart';
import '../state/math_battle_state.dart';

class MatchTimer extends StatelessWidget {
  const MatchTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(6),
      ),
      child: BlocBuilder<MathBattleCubit, MathBattleState>(
        buildWhen: (previous, current) => previous.matchEndsIn != current.matchEndsIn,
        builder: (_, state) {
          final matchEndsInMillis = state.matchEndsIn?.inMilliseconds ?? 0;

          return Text(
            formatDuration(matchEndsInMillis, format: DurationFormat.mmss),
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
          );
        },
      ),
    );
  }
}
