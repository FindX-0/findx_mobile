import 'package:injectable/injectable.dart';

import '../../../shared/values/constants.dart';
import '../model/math_battle_score_changed.dart';
import '../model/math_battle_score_changed_dto.dart';

@lazySingleton
class MathBattleScoreChangedMapper {
  MathBattleScoreChanged dtoToModel(MathBattleScoreChangedDto dto) {
    return MathBattleScoreChanged(
      matchId: dto.matchId ?? kInvalidId,
      scores: dto.scores?.map(_mapScore).toList() ?? [],
    );
  }

  MathBattleUserScore _mapScore(MathBattleUserScoreDto e) {
    return MathBattleUserScore(
      userId: e.userId ?? kInvalidId,
      score: e.score ?? 0,
    );
  }
}
