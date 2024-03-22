import 'package:freezed_annotation/freezed_annotation.dart';

part 'math_battle_result.freezed.dart';

@freezed
class MathBattleResult with _$MathBattleResult {
  const factory MathBattleResult({
    required String id,
    required String userId,
    required DateTime? createdAt,
    required int score,
    required bool isWinner,
    required bool isDraw,
    required String matchId,
    required int trophyChange,
  }) = _MathBattleResult;
}
