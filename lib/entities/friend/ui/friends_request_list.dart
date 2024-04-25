import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../shared/logger.dart';
import '../../../shared/ui/widgets/container_icon_button.dart';
import '../../../shared/util/color.dart';
import '../../../shared/util/equality.dart';
import '../../../shared/values/app_theme_extension.dart';
import '../../../shared/values/assets.dart';
import '../state/friends_list_state.dart';
import 'friend_list_item.dart';

class FriendRequestList extends StatelessWidget {
  const FriendRequestList({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return BlocBuilder<FriendsListCubit, FriendsListState>(
      buildWhen: (previous, current) => notDeepEquals(previous.friendRequests, current.friendRequests),
      builder: (_, state) {
        logger.i(state.friendRequests);
        return state.friendRequests.maybeWhen(
          orElse: () => const SliverToBoxAdapter(),
          success: (data) {
            if (data.isEmpty) {
              return SliverToBoxAdapter(
                child: Align(
                  child: Text(l.noFriendRequests),
                ),
              );
            }

            return SliverList.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final friend = data[index];

                return FriendListItem(
                  name: friend.user?.userName ?? '',
                  end: _AcceptDeclineButtons(friend: friend),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _AcceptDeclineButtons extends StatelessWidget {
  const _AcceptDeclineButtons({
    required this.friend,
  });

  final FriendWithRel friend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ContainerIconButton(
          onPressed: () => context.friendsListCubit.onDeclineFriendRequestPressed(friend),
          child: SvgPicture.asset(
            Assets.iconCancel,
            width: 16,
            height: 16,
            colorFilter: svgColor(theme.colorScheme.onSecondary),
          ),
        ),
        const SizedBox(width: 8),
        ContainerIconButton(
          onPressed: () => context.friendsListCubit.onAcceptFriendRequestPressed(friend),
          color: theme.appThemeExtension?.secondaryVariant,
          child: SvgPicture.asset(
            Assets.iconCheck,
            width: 16,
            height: 16,
            colorFilter: svgColor(theme.colorScheme.onSecondary),
          ),
        ),
      ],
    );
  }
}
