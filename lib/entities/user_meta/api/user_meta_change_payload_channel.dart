import 'package:findx_dart_client/app_client.dart';

import '../model/user_meta_change_payload.dart';

abstract class UserMetaChangePayloadChannel extends SocketChannel<UserMetaChangePayload> {
  UserMetaChangePayloadChannel(super.socketInstanceProvider);
}
