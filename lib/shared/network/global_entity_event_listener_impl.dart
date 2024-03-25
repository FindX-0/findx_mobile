import 'package:injectable/injectable.dart';

import '../../entities/user_meta/api/user_meta_change_payload_channel.dart';
import '../../entities/user_meta/model/user_meta_change_payload.dart';
import 'global_entity_event_listener.dart';

@LazySingleton(as: GlobalEntityEventListener)
class GlobalEntityEventListenerImpl implements GlobalEntityEventListener {
  GlobalEntityEventListenerImpl(
    this._userMetaChangePayloadChannel,
  );

  final UserMetaChangePayloadChannel _userMetaChangePayloadChannel;

  @override
  Future<void> init() async {
    await Future.wait([
      _userMetaChangePayloadChannel.startListening(),
    ]);
  }

  @override
  Future<void> dispose() async {
    await Future.wait([
      _userMetaChangePayloadChannel.dispose(),
    ]);
  }

  @override
  Stream<UserMetaChangePayload> get userMetaChangePayloadEvents => _userMetaChangePayloadChannel.events;
}
