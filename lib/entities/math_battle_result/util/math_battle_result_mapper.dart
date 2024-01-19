import 'package:findx_dart_client/app_client.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/util/mappers.dart';
import '../../../shared/values/constants.dart';
import '../model/math_battle_result.dart';
import '../model/math_battle_result_dto.dart';

@lazySingleton
class MathBattleResultMapper {
  MathBattleResult dtoToModel(MathBattleResultDto dto) {
    return MathBattleResult(
      id: dto.id ?? kInvalidId,
      userId: dto.userId ?? kInvalidId,
      createdAt: tryMapDate(dto.createdAt),
      score: dto.score ?? 0,
      isWinner: dto.isWinner ?? false,
      isDraw: dto.isDraw ?? false,
      matchId: dto.matchId ?? kInvalidId,
    );
  }

  GetMathBattleResultsRes dtoToGqlModel(MathBattleResult model) {
    return GetMathBattleResultsRes(
      id: model.id,
      userId: model.userId,
      createdAt: model.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      score: model.score,
      isWinner: model.isWinner,
      isDraw: model.isDraw,
      matchId: model.matchId,
    );
  }

  List<MathBattleResult> resultChangedListDtoToModel(List<MathBattleResultDto> dto) {
    return dto.map(dtoToModel).toList();
  }
}
