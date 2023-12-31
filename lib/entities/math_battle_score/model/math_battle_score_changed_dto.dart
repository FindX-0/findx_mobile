import 'package:freezed_annotation/freezed_annotation.dart';

part 'math_battle_score_changed_dto.g.dart';

part 'math_battle_score_changed_dto.freezed.dart';

@freezed
class MathBattleScoreChangedDto with _$MathBattleScoreChangedDto {
  const factory MathBattleScoreChangedDto({
    String? matchId,
    List<MathBattleUserScoreDto>? scores,
  }) = _MathBattleScoreChangedDto;

  factory MathBattleScoreChangedDto.fromJson(Map<String, dynamic> json) =>
      _$MathBattleScoreChangedDtoFromJson(json);
}

@freezed
class MathBattleUserScoreDto with _$MathBattleUserScoreDto {
  const factory MathBattleUserScoreDto({
    String? userId,
    int? score,
  }) = _MathBattleUserScoreDto;

  factory MathBattleUserScoreDto.fromJson(Map<String, dynamic> json) =>
      _$MathBattleUserScoreDtoFromJson(json);
}
