import 'package:findx_dart_client/app_client.dart';
import 'package:injectable/injectable.dart';

import 'after_sign_out.dart';

@LazySingleton(as: AfterSignOut)
class AfterSignOutImpl implements AfterSignOut {
  AfterSignOutImpl(
    this._socketInstanceProvider,
  );

  final SocketInstanceProvider _socketInstanceProvider;

  @override
  Future<void> call() async {
    await _socketInstanceProvider.dispose();
  }
}
