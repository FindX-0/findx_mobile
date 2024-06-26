import 'package:common_widgets/common_widgets.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/intl/app_localizations.dart';
import '../state/search_friends_state.dart';

class SearchFriendsList extends StatelessWidget {
  const SearchFriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFriendsCubit, SearchFriendsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          success: (data) => PagedList(
            data: data.items,
            totalCount: data.count,
            onScrolledToEnd: context.searchFriendsCubit.fetchNextPage,
            itemBuilder: (_, __, item) => _Item(user: item),
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.user,
  });

  final FilterUsersDataRes user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);

    final isButtonDisabled = user.friendshipStatus != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          BlankContainer(
            borderRadius: BorderRadius.circular(4),
            color: theme.colorScheme.secondary,
            width: 42,
            height: 42,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              user.userName ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: TextButton(
              onPressed: isButtonDisabled ? null : () => context.searchFriendsCubit.onAddFriend(user),
              style: TextButton.styleFrom(
                backgroundColor: isButtonDisabled ? theme.colorScheme.primaryContainer : null,
              ),
              child: Text(_buttonLabel(l)),
            ),
          ),
        ],
      ),
    );
  }

  String _buttonLabel(AppLocalizations l) {
    return switch (user.friendshipStatus) {
      FriendshipStatus.ACCEPTED => l.friends,
      FriendshipStatus.REQUESTED => l.requestSent,
      _ => l.add,
    };
  }
}
