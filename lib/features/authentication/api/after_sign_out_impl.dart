import 'package:findx_dart_client/app_client.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/network/global_entity_event_listener.dart';
import 'after_sign_out.dart';

@LazySingleton(as: AfterSignOut)
class AfterSignOutImpl implements AfterSignOut {
  AfterSignOutImpl(
    this._socketInstanceProvider,
    this._globalEntityEventListener,
    this._authTokenStore,
  );

  final SocketInstanceProvider _socketInstanceProvider;
  final GlobalEntityEventListener _globalEntityEventListener;
  final AuthTokenStore _authTokenStore;

  @override
  Future<void> call() async {
    await _globalEntityEventListener.dispose();
    await _socketInstanceProvider.dispose();
    await _authTokenStore.clear();
  }
}
