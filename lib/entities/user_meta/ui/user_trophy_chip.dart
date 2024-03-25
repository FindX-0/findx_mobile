import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/di/register_dependencies.dart';
import '../../../shared/util/color.dart';
import '../../../shared/values/assets.dart';
import '../state/user_meta_state.dart';

class UserTrophyChip extends StatelessWidget {
  const UserTrophyChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserMetaCubit>(),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.secondary,
      ),
      child: BlocBuilder<UserMetaCubit, UserMetaState>(
        builder: (_, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            success: (data) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Assets.iconTrophy,
                  width: 16,
                  height: 16,
                  colorFilter: svgColor(theme.colorScheme.onSecondary),
                ),
                const SizedBox(width: 6),
                Text(
                  data.trophies.toString(),
                  style: TextStyle(
                    color: theme.colorScheme.onSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
