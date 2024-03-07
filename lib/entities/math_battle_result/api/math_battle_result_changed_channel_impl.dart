import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../shared/network/gateway_event.dart';
import '../model/math_battle_result.dart';
import '../model/math_battle_result_dto.dart';
import '../util/math_battle_result_mapper.dart';
import 'math_battle_result_changed_channel.dart';

@Injectable(as: MathBattleResultChangedChannel)
class MathBattleResultChangedChannelImpl extends MathBattleResultChangedChannel {
  MathBattleResultChangedChannelImpl(
    super.socketInstanceProvider,
    this._mapper,
  );

  final MathBattleResultMapper _mapper;

  @override
  String get event => GatewayEvent.mathBattleResultsChanged;

  @override
  FutureOr<List<MathBattleResult>> map(dynamic payload) {
    if (event is! List<dynamic>) {
      return [];
    }

    return payload
        .map((e) {
          if (e is! Map<String, dynamic>) {
            return null;
          }

          return _mapper.dtoToModel(MathBattleResultDto.fromJson(e));
        })
        .where((element) => element != null)
        .cast<MathBattleResult>()
        .toList();
  }
}
