import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/intl/app_localizations.dart';
import '../state/friends_list_state.dart';
import 'friend_list_item.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return BlocBuilder<FriendsListCubit, FriendsListState>(
      buildWhen: (previous, current) => previous.friends != current.friends,
      builder: (_, state) {
        return state.friends.maybeWhen(
          orElse: () => const SliverToBoxAdapter(),
          success: (data) {
            if (data.isEmpty) {
              return SliverToBoxAdapter(
                child: Align(
                  child: Text(l.noFriends),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => context.friendsListCubit.onDeclineFriendRequestPressed(friend),
          icon: const Icon(Icons.cancel),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () => context.friendsListCubit.onAcceptFriendRequestPressed(friend),
          icon: const Icon(Icons.done),
        ),
      ],
    );
  }
}
