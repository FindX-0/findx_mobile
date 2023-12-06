import 'package:app_client/app_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/app_environment.dart';
import '../../injection_token.dart';

@module
abstract class AppClientAuthenticationModule {
  @lazySingleton
  AuthTokenStore authTokenStore(FlutterSecureStorage flutterSecureStorage) {
    return SecureStoreageTokenStoreImpl(flutterSecureStorage);
  }

  @lazySingleton
  RefreshTokenUsecase refreshTokenUsecase(@Named(InjectionToken.noInterceptorDio) Dio dio) {
    return RefreshTokenUsecaseImpl(dio, AppEnvironment.apiUrl);
  }

  @lazySingleton
  ValidateAuthTokenUsecase validateAuthTokenUsecase(
    @Named(InjectionToken.noInterceptorDio) Dio dio,
  ) {
    return ValidateAuthTokenUsecaseImpl(
      dio,
      AppEnvironment.apiUrl,
    );
  }
}
