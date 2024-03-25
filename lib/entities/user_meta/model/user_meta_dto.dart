import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_meta_dto.g.dart';

part 'user_meta_dto.freezed.dart';

@freezed
class UserMetaDto with _$UserMetaDto {
  const factory UserMetaDto({
    String? id,
    String? createdAt,
    double? trophies,
    String? userId,
  }) = _UserMetaDto;

  factory UserMetaDto.fromJson(Map<String, dynamic> json) => _$UserMetaDtoFromJson(json);
}
