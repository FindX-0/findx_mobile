import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/values/constants.dart';
import '../model/user_meta_change_payload.dart';
import '../model/user_meta_change_payload_dto.dart';
import 'user_meta_mapper.dart';

@lazySingleton
class UserMetaChangePayloadMapper {
  UserMetaChangePayloadMapper(
    this._userMetaMapper,
  );

  final UserMetaMapper _userMetaMapper;

  UserMetaChangePayload dtoToModel(UserMetaChangePayloadDto dto) {
    return UserMetaChangePayload(
      userMeta: tryMap(dto.userMeta, _userMetaMapper.dtoToModel),
      userMetaChange: tryMap(dto.userMetaChange, _mapUserMetaChange),
    );
  }

  UserMetaChange _mapUserMetaChange(UserMetaChangeDto dto) {
    return UserMetaChange(
      trophyChange: dto.trophyChange?.floor() ?? 0,
      matchId: dto.matchId ?? kInvalidId,
    );
  }
}
