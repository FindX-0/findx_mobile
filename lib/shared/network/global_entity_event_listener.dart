import '../../entities/user_meta/model/user_meta_change_payload.dart';

abstract interface class GlobalEntityEventListener {
  Future<void> init();

  Future<void> dispose();

  Stream<UserMetaChangePayload> get userMetaChangePayloadEvents;
}
