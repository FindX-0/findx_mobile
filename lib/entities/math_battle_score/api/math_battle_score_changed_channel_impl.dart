import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../shared/network/gateway_event.dart';
import '../model/math_battle_score_changed.dart';
import '../model/math_battle_score_changed_dto.dart';
import '../util/math_battle_score_changed_mapper.dart';
import 'math_battle_score_changed_channel.dart';

@Injectable(as: MathBattleScoreChangedChannel)
class MathBattleScoreChangedChannelImpl extends MathBattleScoreChangedChannel {
  MathBattleScoreChangedChannelImpl(
    super.socketInstanceProvider,
    this._mathBattleScoreChangedMapper,
  );

  final MathBattleScoreChangedMapper _mathBattleScoreChangedMapper;

  @override
  String get event => GatewayEvent.mathBattleScoreChanged;

  @override
  FutureOr<MathBattleScoreChanged> map(dynamic event) {
    return _mathBattleScoreChangedMapper.dtoToModel(
      MathBattleScoreChangedDto.fromJson(event as Map<String, dynamic>),
    );
  }
}
