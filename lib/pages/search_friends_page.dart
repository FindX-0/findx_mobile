import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../entities/friend/state/search_friends_state.dart';
import '../entities/friend/ui/search_friends_field.dart';
import '../entities/friend/ui/search_friends_list.dart';
import '../shared/ui/widgets/default_back_button.dart';

class SearchFriendsPage extends StatelessWidget {
  const SearchFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchFriendsCubit>(),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DefaultBackButton(),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SearchFriendsField(),
            ),
            SearchFriendsList(),
          ],
        ),
      ),
    );
  }
}
