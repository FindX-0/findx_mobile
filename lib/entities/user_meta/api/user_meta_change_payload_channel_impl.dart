import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../shared/network/gateway_event.dart';
import '../model/user_meta_change_payload.dart';
import '../model/user_meta_change_payload_dto.dart';
import '../util/user_meta_change_payload_mapper.dart';
import 'user_meta_change_payload_channel.dart';

@Injectable(as: UserMetaChangePayloadChannel)
class UserMetaChangePayloadChannelImpl extends UserMetaChangePayloadChannel {
  UserMetaChangePayloadChannelImpl(
    super.socketInstanceProvider,
    this._userMetaChangePayloadMapper,
  );

  final UserMetaChangePayloadMapper _userMetaChangePayloadMapper;

  @override
  String get event => GatewayEvent.userMetaChanged;

  @override
  FutureOr<UserMetaChangePayload> map(dynamic payload) {
    return _userMetaChangePayloadMapper.dtoToModel(
      UserMetaChangePayloadDto.fromJson(payload as Map<String, dynamic>),
    );
  }
}
