import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../shared/logger.dart';
import '../../../shared/ui/toast/toast_notifier.dart';

part 'friends_list_state.freezed.dart';

@freezed
class FriendsListState with _$FriendsListState {
  const factory FriendsListState({
    required DataState<NetworkCallError, List<FriendWithRel>> friendRequests,
    required DataState<NetworkCallError, List<FriendWithRel>> friends,
  }) = _FriendsListState;

  factory FriendsListState.initial() => FriendsListState(
        friendRequests: DataState.idle(),
        friends: DataState.idle(),
      );
}

extension FriendsListCubitX on BuildContext {
  FriendsListCubit get friendsListCubit => read<FriendsListCubit>();
}

@injectable
final class FriendsListCubit extends Cubit<FriendsListState> {
  FriendsListCubit(
    this._friendRemoteRepository,
    this._pageNavigator,
    this._toastNotifier,
  ) : super(FriendsListState.initial()) {
    _init();
  }

  final FriendRemoteRepository _friendRemoteRepository;
  final PageNavigator _pageNavigator;
  final ToastNotifier _toastNotifier;

  Future<void> _init() async {
    await _loadFriends();
    await _loadFriendRequests();
  }

  Future<void> _loadFriends() async {
    emit(state.copyWith(friends: DataState.loading()));

    final friends = await _friendRemoteRepository.getFriends();

    emit(state.copyWith(friends: DataState.fromEither(friends)));
  }

  Future<void> _loadFriendRequests() async {
    emit(state.copyWith(friendRequests: DataState.loading()));

    final friendRequests = await _friendRemoteRepository.getFriendRequests();

    emit(state.copyWith(friendRequests: DataState.fromEither(friendRequests)));
  }

  Future<void> onDeclineFriendRequestPressed(FriendWithRel friend) async {
    final res = await _friendRemoteRepository.declineFriendRequest(userId: friend.userId);

    if (res.isLeft) {
      _toastNotifier.notify(
        message: (l) => l.failedToDeclineFriendRequest,
        title: (l) => l.error,
      );
      return;
    }

    final newState = await state.friendRequests.map((data) {
      final dataClone = List.of(data);
      dataClone.removeWhere((e) => e.userId == friend.userId);
      return dataClone;
    });

    emit(state.copyWith(friendRequests: newState));
  }

  Future<void> onAcceptFriendRequestPressed(FriendWithRel friend) async {
    final res = await _friendRemoteRepository.acceptFriendRequest(userId: friend.userId);

    if (res.isLeft) {
      _toastNotifier.notify(
        message: (l) => l.failedToAcceptFriendRequest,
        title: (l) => l.error,
      );
      return;
    }

    final newState = await state.friendRequests.map((data) {
      final dataClone = List.of(data);
      dataClone.removeWhere((e) => e.userId == friend.userId);
      return dataClone;
    });

    emit(state.copyWith(friendRequests: newState));

    return _loadFriends();
  }

  void onSearchPressed() {
    _pageNavigator.toSearchFriends();
  }
}
