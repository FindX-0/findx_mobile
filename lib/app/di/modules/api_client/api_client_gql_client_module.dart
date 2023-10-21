import 'package:app_client/app_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../features/authentication/api/after_sign_out.dart';
import '../../../../shared/app_environment.dart';
import '../../../../shared/logger.dart';
import '../../injection_token.dart';

@module
abstract class ApiClientGqlClientModule {
  @lazySingleton
  @Named(InjectionToken.apiDio)
  Dio dio(
    AuthTokenStore authTokenStore,
    @Named(InjectionToken.noInterceptorDio) Dio noInterceptorDio,
    AfterSignOut afterSignOut,
  ) {
    return NetworkClientFactory.createAuthenticatedDio(
      noInterceptorDio: noInterceptorDio,
      authTokenStore: authTokenStore,
      afterExit: afterSignOut.call,
      logPrint: logger.d,
      apiUrl: AppEnvironment.apiUrl,
    );
  }

  @lazySingleton
  @Named(InjectionToken.noInterceptorDio)
  Dio refreshTokenDio() {
    return NetworkClientFactory.createNoInterceptorDio(
      logPrint: logger.d,
      apiUrl: AppEnvironment.apiUrl,
    );
  }

  @lazySingleton
  GqlApiClient gqlApiClient(
    @Named(InjectionToken.apiDio) Dio dio,
  ) {
    return NetworkClientFactory.createGqlApiClient(
      dio: dio,
      apiUrl: AppEnvironment.apiUrl,
    );
  }
}
