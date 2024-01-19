import 'package:findx_dart_client/app_client.dart';

import '../model/math_battle_result.dart';

abstract class MathBattleResultChangedChannel extends SocketChannel<List<MathBattleResult>> {
  MathBattleResultChangedChannel(super.socketInstanceProvider);
}
