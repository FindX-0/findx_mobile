import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_meta.freezed.dart';

@freezed
class UserMeta with _$UserMeta {
  const factory UserMeta({
    required String id,
    required DateTime? createdAt,
    required int trophies,
    required String userId,
  }) = _UserMeta;
}
