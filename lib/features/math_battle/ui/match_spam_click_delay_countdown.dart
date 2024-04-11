import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/util/format/duration.dart';
import '../state/math_battle_state.dart';

class MatchSpamClickDelayCountdown extends StatelessWidget {
  const MatchSpamClickDelayCountdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MathBattleCubit, MathBattleState>(
      buildWhen: (previous, current) => previous.spamClickDelayLeft != current.spamClickDelayLeft,
      builder: (_, state) {
        if (state.spamClickDelayLeft == null) {
          return const SizedBox.shrink();
        }

        final spamClickDelayLeftMillis = state.spamClickDelayLeft!.inMilliseconds;

        return Container(
          padding: EdgeInsets.symmetric(vertical: 24.r),
          color: Colors.black38,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Spam click detected',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                formatDuration(spamClickDelayLeftMillis, format: DurationFormat.hhmmssShort),
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
