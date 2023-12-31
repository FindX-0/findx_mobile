import 'package:findx_dart_client/app_client.dart';

import '../../ticket/model/ticket.dart';
import '../model/math_battle_score_changed.dart';

abstract class MathBattleScoreChangedChannel extends SocketChannel<MathBattleScoreChanged> {
  MathBattleScoreChangedChannel(super.socketInstanceProvider);
}
