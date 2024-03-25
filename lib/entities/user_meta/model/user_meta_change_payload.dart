import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_meta.dart';

part 'user_meta_change_payload.freezed.dart';

@freezed
class UserMetaChangePayload with _$UserMetaChangePayload {
  const factory UserMetaChangePayload({
    required UserMeta? userMeta,
    required UserMetaChange? userMetaChange,
  }) = _UserMetaChangePayload;
}

@freezed
class UserMetaChange with _$UserMetaChange {
  const factory UserMetaChange({
    required int trophyChange,
    required String matchId,
  }) = _UserMetaChange;
}
