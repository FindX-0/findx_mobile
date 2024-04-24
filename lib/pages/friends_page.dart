import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../app/intl/app_localizations.dart';
import '../entities/friend/state/friends_list_state.dart';
import '../entities/friend/ui/friends_list.dart';
import '../entities/friend/ui/friends_request_list.dart';
import '../shared/ui/widgets/default_back_button.dart';
import '../shared/ui/widgets/non_interactive_search_field.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FriendsListCubit>(),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: const DefaultBackButton(),
        title: Text(l.friends),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: NonInteractiveSearchField(onTap: context.friendsListCubit.onSearchPressed),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 10),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        l.requests,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const FriendsList(),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 10),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        l.friends,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const FriendRequestList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
