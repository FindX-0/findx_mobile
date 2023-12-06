import 'package:dio/dio.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import '../../../../features/authentication/api/after_sign_out.dart';
import '../../../../shared/app_environment.dart';
import '../../../../shared/logger.dart';
import '../../injection_token.dart';

@module
abstract class AppNetworkClientModule {
  @lazySingleton
  @Named(InjectionToken.apiDio)
  Dio dio(
    AuthTokenStore authTokenStore,
    @Named(InjectionToken.noInterceptorDio) Dio noInterceptorDio,
    AfterSignOut afterSignOut,
    RefreshTokenUsecase refreshTokenUsecase,
  ) {
    return NetworkClientFactory.createAuthenticatedDio(
      noInterceptorDio: noInterceptorDio,
      authTokenStore: authTokenStore,
      afterExit: afterSignOut.call,
      logPrint: logger.d,
      apiUrl: AppEnvironment.apiUrl,
      refreshTokenUsecase: refreshTokenUsecase,
    );
  }

  @lazySingleton
  @Named(InjectionToken.noInterceptorDio)
  Dio noInterceptorDio() {
    return NetworkClientFactory.createNoInterceptorDio(
      logPrint: logger.d,
      apiUrl: AppEnvironment.apiUrl,
    );
  }

  @lazySingleton
  GraphQLClient gqlClient(
    @Named(InjectionToken.apiDio) Dio dio,
  ) {
    return NetworkClientFactory.createGqlClient(
      dio: dio,
      apiUrl: AppEnvironment.apiUrl,
    );
  }

  @lazySingleton
  SocketInstanceProvider socketInstanceProvider(
    AuthTokenStore authTokenStore,
    ValidateAuthTokenUsecase validateAuthTokenUsecase,
  ) {
    return SocketInstanceProviderImpl(
      authTokenStore,
      validateAuthTokenUsecase,
      AppEnvironment.wsUrl,
    );
  }
}
