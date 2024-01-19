import 'package:findx_dart_client/app_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'two_player_math_battle_results.freezed.dart';

@freezed
class TwoPlayerMathBattleResults with _$TwoPlayerMathBattleResults {
  const factory TwoPlayerMathBattleResults({
    required GetMathBattleResultsRes myResult,
    required GetMathBattleResultsRes opponentRes,
  }) = _TwoPlayerMathBattleResults;
}
