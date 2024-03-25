import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_meta_dto.dart';

part 'user_meta_change_payload_dto.g.dart';

part 'user_meta_change_payload_dto.freezed.dart';

@freezed
class UserMetaChangePayloadDto with _$UserMetaChangePayloadDto {
  const factory UserMetaChangePayloadDto({
    UserMetaDto? userMeta,
    UserMetaChangeDto? userMetaChange,
  }) = _UserMetaChangePayloadDto;

  factory UserMetaChangePayloadDto.fromJson(Map<String, dynamic> json) =>
      _$UserMetaChangePayloadDtoFromJson(json);
}

@freezed
class UserMetaChangeDto with _$UserMetaChangeDto {
  const factory UserMetaChangeDto({
    double? trophyChange,
    String? matchId,
  }) = _UserMetaChangeDto;

  factory UserMetaChangeDto.fromJson(Map<String, dynamic> json) => _$UserMetaChangeDtoFromJson(json);
}
