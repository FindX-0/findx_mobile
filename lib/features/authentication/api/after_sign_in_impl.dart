import 'package:injectable/injectable.dart';

import 'after_sign_in.dart';

@LazySingleton(as: AfterSignIn)
class AfterSignInImpl implements AfterSignIn {
  AfterSignInImpl();

  @override
  Future<void> call() async {}
}
