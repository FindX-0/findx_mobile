import 'package:findx_dart_client/app_client.dart';
import 'package:injectable/injectable.dart';

import 'after_sign_out.dart';

@LazySingleton(as: AfterSignOut)
class AfterSignOutImpl implements AfterSignOut {
  AfterSignOutImpl(
    this._socketInstanceProvider,
    this._authTokenStore,
  );

  final SocketInstanceProvider _socketInstanceProvider;
  final AuthTokenStore _authTokenStore;

  @override
  Future<void> call() async {
    await _socketInstanceProvider.dispose();
    await _authTokenStore.clear();
  }
}
