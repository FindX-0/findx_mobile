import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'auth_status_provider.dart';

@LazySingleton(as: AuthStatusProvider)
class AuthStatusProviderImpl implements AuthStatusProvider {
  AuthStatusProviderImpl(this._googleSignIn);

  final GoogleSignIn _googleSignIn;

  @override
  Future<bool> get() {
    return _googleSignIn.isSignedIn();
  }
}
