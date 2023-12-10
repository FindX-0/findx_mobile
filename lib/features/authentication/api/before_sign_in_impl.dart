import 'package:findx_dart_client/app_client.dart';
import 'package:injectable/injectable.dart';

import 'before_sign_in.dart';

@LazySingleton(as: BeforeSignIn)
class BeforeSignInImpl implements BeforeSignIn {
  BeforeSignInImpl(
    this._socketInstanceProvider,
  );

  final SocketInstanceProvider _socketInstanceProvider;

  @override
  Future<void> call() async {
    await _socketInstanceProvider.dispose();
  }
}
