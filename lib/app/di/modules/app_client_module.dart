import 'package:dio/dio.dart';
import 'package:findx_dart_client/app_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/app_environment.dart';
import '../injection_token.dart';

@module
abstract class AppClientModule {
  // auth ---------------------------------------------------------------------
  @lazySingleton
  AuthTokenStore authTokenStore(FlutterSecureStorage flutterSecureStorage) {
    return SecureStoreageTokenStoreImpl(flutterSecureStorage);
  }

  @lazySingleton
  RefreshTokenUsecase refreshTokenUsecase(
    @Named(InjectionToken.noInterceptorDio) Dio dio,
  ) {
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

  @lazySingleton
  AuthenticationFacade authenticationFacade(GraphQLClient client) {
    return ApiAuthenticationFacade(client);
  }

  // user ---------------------------------------------------------------------
  @lazySingleton
  UserRemoteRepository userRemoteRepository(GraphQLClient client) {
    return ApiUserRemoteRepository(client);
  }

  // user meta ----------------------------------------------------------------
  @lazySingleton
  UserMetaRemoteRepository userMetaRemoteRepository(GraphQLClient client) {
    return ApiUserMetaRemoteRepository(client);
  }

  // server time --------------------------------------------------------------
  @lazySingleton
  ServerTimeRemoteRepository serverTimeRemoteRepository(GraphQLClient client) {
    return ApiServerTimeRemoteRepository(client);
  }

  // math field --------------------------------------------------------------
  @lazySingleton
  MathFieldRemoteRepository mathFieldRemoteRepository(GraphQLClient client) {
    return ApiMathFieldRemoteRepository(client);
  }

  // math battle result ------------------------------------------------------
  @lazySingleton
  MathBattleResultRemoteRepository mathBattleResultRemoteRepository(GraphQLClient client) {
    return ApiMathBattleResultRemoteRepository(client);
  }

  // math battle -------------------------------------------------------------
  @lazySingleton
  MathBattleRemoteRepository mathBattleRemoteRepository(GraphQLClient client) {
    return ApiMathBattleRemoteRepository(client);
  }

  // matchmaking -------------------------------------------------------------
  @lazySingleton
  MatchmakingRemoteRepository ticketRemoteRepository(GraphQLClient client) {
    return ApiMatchmakingRemoteRepository(client);
  }

  // friend
  @lazySingleton
  FriendRemoteRepository friendRemoteRepository(GraphQLClient client) {
    return ApiFriendRemoteRepository(client);
  }
}
