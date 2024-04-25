import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/state/searchable_data_pager_with_last_id_cubit.dart';
import '../../../shared/ui/toast/toast_notifier.dart';

typedef SearchFriendsState = DataState<NetworkCallError, DataPage<FilterUsersDataRes>>;

extension SearchFriendsCubitX on BuildContext {
  SearchFriendsCubit get searchFriendsCubit => read<SearchFriendsCubit>();
}

@injectable
final class SearchFriendsCubit
    extends SearchableDataPagerWithLastIdCubit<NetworkCallError, FilterUsersDataRes> {
  SearchFriendsCubit(
    this._userRemoteRepository,
    this._friendRemoteRepository,
    this._toastNotifier,
  ) : super(allowEmptyQuery: false);

  final UserRemoteRepository _userRemoteRepository;
  final FriendRemoteRepository _friendRemoteRepository;
  final ToastNotifier _toastNotifier;

  @override
  String idSelector(FilterUsersDataRes item) => item.id;

  @override
  Future<Either<NetworkCallError, DataPage<FilterUsersDataRes>>> searchDataPage(
    String? lastId,
    String searchQuery,
  ) {
    return _userRemoteRepository.filter(
      lastId: lastId,
      limit: 20,
      searchQuery: searchQuery,
    );
  }

  Future<void> onAddFriend(FilterUsersDataRes user) async {
    final res = await _friendRemoteRepository.sendFriendRequest(userId: user.id);

    if (res.isLeft) {
      _toastNotifier.notify(
        message: (l) => l.failedToSendFriendRequest,
        title: (l) => l.error,
      );

      return;
    }

    final newState = await state.map((data) {
      final items = data.items.replace(
        (e) => e.id == user.id,
        (old) => old.copyWith(friendshipStatus: FriendshipStatus.REQUESTED),
      );

      return data.copyWith(items: items);
    });

    emit(newState);
  }
}
