import 'package:common_models/common_models.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

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
  ) : super(FriendsListState.initial()) {
    _init();
  }

  final FriendRemoteRepository _friendRemoteRepository;

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

  void onDeclineFriendRequestPressed(FriendWithRel friend) {}

  void onAcceptFriendRequestPressed(FriendWithRel friend) {}

  void onSearchPressed() {}
}
