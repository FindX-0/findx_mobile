import 'dart:developer';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/app_environment.dart';

@module
abstract class OauthModule {
  @lazySingleton
  GoogleSignIn get googleSignIn {
    log('android key = ${AppEnvironment.googleAuthClientIdAndroid}');
    log('ios key = ${AppEnvironment.googleAuthClientIdIos}');

    return GoogleSignIn(
      clientId: Platform.isIOS ? AppEnvironment.googleAuthClientIdIos : null,
    );
  }
}
