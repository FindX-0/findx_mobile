import 'package:common_network_components/common_network_components.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql/client.dart';

import '../shared/typedefs.dart';
import '../store/auth_token_store.dart';
import 'gql_api_client.dart';
import 'interceptor/authorization_interceptor.dart';

const Duration _kTimeoutDuration = Duration(seconds: 20);

final class NetworkClientFactory {
  static GqlApiClient createGqlApiClient({
    required Dio dio,
    required String apiUrl,
  }) {
    final link = Link.from([
      DioLink('/graphql', client: dio),
    ]);

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );

    return GqlApiClient(client);
  }

  static Dio createNoInterceptorDio({
    required String apiUrl,
    LogPrint? logPrint,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        contentType: 'application/json',
        connectTimeout: _kTimeoutDuration,
        sendTimeout: _kTimeoutDuration,
        receiveTimeout: _kTimeoutDuration,
      ),
    );

    if (kDebugMode && logPrint != null) {
      dio.interceptors.add(PrettyLogInterceptor(logPrint: logPrint));
    }

    return dio;
  }

  static Dio createAuthenticatedDio({
    required Dio noInterceptorDio,
    required AuthTokenStore authTokenStore,
    required VoidCallback afterExit,
    required LogPrint? logPrint,
    required String apiUrl,
  }) {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        contentType: 'application/json',
        connectTimeout: _kTimeoutDuration,
        sendTimeout: _kTimeoutDuration,
        receiveTimeout: _kTimeoutDuration,
      ),
    );

    dio.interceptors.add(AuthorizationInterceptor(
      authTokenStore,
      noInterceptorDio,
      apiUrl,
      afterExit,
    ));

    if (kDebugMode && logPrint != null) {
      dio.interceptors.add(PrettyLogInterceptor(logPrint: logPrint));
    }

    return dio;
  }
}
