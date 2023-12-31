import 'package:freezed_annotation/freezed_annotation.dart';

part 'math_battle_score_changed.freezed.dart';

@freezed
class MathBattleScoreChanged with _$MathBattleScoreChanged {
  const factory MathBattleScoreChanged({
    required String matchId,
    required List<MathBattleUserScore> scores,
  }) = _MathBattleScoreChanged;
}

@freezed
class MathBattleUserScore with _$MathBattleUserScore {
  const factory MathBattleUserScore({
    required String userId,
    required int score,
  }) = _MathBattleUserScore;
}
