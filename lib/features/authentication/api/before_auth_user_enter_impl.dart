import 'package:injectable/injectable.dart';

import '../../../shared/network/global_entity_event_listener.dart';
import 'before_auth_user_enter.dart';

@LazySingleton(as: BeforeAuthUserEnter)
class BeforeAuthUserEnterImpl implements BeforeAuthUserEnter {
  BeforeAuthUserEnterImpl(
    this._globalEntityEventListener,
  );

  final GlobalEntityEventListener _globalEntityEventListener;

  @override
  Future<void> call() async {
    return _globalEntityEventListener.init();
  }
}
