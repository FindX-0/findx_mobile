import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/values/constants.dart';
import '../model/user_meta.dart';
import '../model/user_meta_dto.dart';

@lazySingleton
class UserMetaMapper {
  UserMeta dtoToModel(UserMetaDto dto) {
    return UserMeta(
      id: dto.id ?? kInvalidId,
      createdAt: tryMapDate(dto.createdAt),
      trophies: dto.trophies?.floor() ?? 0,
      userId: dto.userId ?? kInvalidId,
    );
  }
}
