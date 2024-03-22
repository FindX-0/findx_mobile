import 'package:freezed_annotation/freezed_annotation.dart';

part 'math_battle_result_dto.g.dart';

part 'math_battle_result_dto.freezed.dart';

@freezed
class MathBattleResultDto with _$MathBattleResultDto {
  const factory MathBattleResultDto({
    String? id,
    String? userId,
    String? createdAt,
    int? score,
    bool? isWinner,
    bool? isDraw,
    String? matchId,
    int? trophyChange,
  }) = _MathBattleResultDto;

  factory MathBattleResultDto.fromJson(Map<String, dynamic> json) => _$MathBattleResultDtoFromJson(json);
}
