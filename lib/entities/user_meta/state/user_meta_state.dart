import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/network/global_entity_event_listener.dart';
import '../model/user_meta_change_payload.dart';

typedef UserMetaState = DataState<FetchFailure, UserMeta>;

@injectable
class UserMetaCubit extends Cubit<UserMetaState> {
  UserMetaCubit(
    this._globalEntityEventListener,
    this._userMetaRemoteRepository,
  ) : super(UserMetaState.idle()) {
    _init();
  }

  final UserMetaRemoteRepository _userMetaRemoteRepository;
  final GlobalEntityEventListener _globalEntityEventListener;

  final _subsciptions = SubscriptionComposite();

  Future<void> _init() async {
    _subsciptions.add(
      _globalEntityEventListener.userMetaChangePayloadEvents.listen(_onUserMetaChanged),
    );

    await _loadUserMeta();
  }

  @override
  Future<void> close() async {
    await _subsciptions.closeAll();

    return super.close();
  }

  void _onUserMetaChanged(UserMetaChangePayload payload) {
    final userMeta = state.getOrNull;
    if (userMeta == null) {
      return;
    }

    final updatedUserMeta = userMeta.copyWith(
      trophies: userMeta.trophies + (payload.userMetaChange?.trophyChange ?? 0),
    );

    emit(UserMetaState.success(updatedUserMeta));
  }

  Future<void> _loadUserMeta() async {
    emit(DataState.loading());
    final res = await _userMetaRemoteRepository.getAuthUserMeta();
    emit(DataState.fromEither(res));
  }
}
