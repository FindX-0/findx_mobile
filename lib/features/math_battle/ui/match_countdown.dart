import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/util/format/duration.dart';
import '../state/math_battle_state.dart';

class MatchCountdown extends StatelessWidget {
  const MatchCountdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MathBattleCubit, MathBattleState>(
      buildWhen: (previous, current) => previous.countdownLeft != current.countdownLeft,
      builder: (_, state) {
        final countdownLeftInMillis = state.countdownLeft?.inMilliseconds ?? 0;

        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.r),
            child: Text(
              formatDuration(countdownLeftInMillis, format: DurationFormat.hhmmssShort),
              style: TextStyle(fontSize: 24.sp),
            ),
          ),
        );
      },
    );
  }
}
