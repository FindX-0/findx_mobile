import 'dart:io';

import 'package:dio/dio.dart';
import 'package:synchronized/synchronized.dart';

import '../../shared/typedefs.dart';
import '../../store/auth_token_store.dart';
import '../util/raw_refresh_token.dart';

class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor(
    this._authTokenStore,
    this._dio,
    this._baseUrl,
    this._afterExit,
  );

  final AuthTokenStore _authTokenStore;
  final Dio _dio;
  final String _baseUrl;
  final VoidCallback _afterExit;

  final _lock = Lock();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await _authTokenStore.readAccessToken();
    if (accessToken == null) {
      return super.onRequest(options, handler);
    }

    await _lock.synchronized(() async {
      accessToken = await _authTokenStore.readAccessToken();
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    });

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized ||
        err.response?.statusCode == HttpStatus.forbidden) {
      final retryResponse = await _lock.synchronized<Response<dynamic>?>(
        () async {
          final bool successfulTokenRefresh = await _tryRefreshAccessToken();
          if (!successfulTokenRefresh) {
            return null;
          }

          try {
            final Response<dynamic> retryResponse = await _retryRequest(err);

            return retryResponse;
          } catch (e) {
            /* ignored */
          }

          return null;
        },
        timeout: const Duration(seconds: 10),
      );

      if (retryResponse != null) {
        return handler.resolve(retryResponse);
      }
    }

    return super.onError(err, handler);
  }

  /// @returns true indicating success, false otherwise
  Future<bool> _tryRefreshAccessToken() async {
    final String? refreshToken = await _authTokenStore.readRefreshToken();
    if (refreshToken == null) {
      return false;
    }

    return _refreshAccessToken(refreshToken);
  }

  /// @returns true indicating success, false otherwise
  Future<bool> _refreshAccessToken(String refreshToken) async {
    final payload = await rawRefreshToken(
      _dio,
      baseUrl: _baseUrl,
      refreshToken: refreshToken,
    );

    if (payload == null || payload.refreshToken == null || payload.accessToken == null) {
      await _clearExit();
      return false;
    }

    await _authTokenStore.writeAccessToken(payload.accessToken!);
    await _authTokenStore.writeRefreshToken(payload.refreshToken!);

    return true;
  }

  Future<void> _clearExit() async {
    final refreshToken = await _authTokenStore.readRefreshToken();

    if (refreshToken != null) {
      // TODO sign out call
      // _dio.post(
      //   '$_baseUrl/Authentication/SignOut',
      //   data: {'refreshToken': refreshToken},
      // );
    }

    await _authTokenStore.clear();
    _afterExit.call();
  }

  Future<Response<dynamic>> _retryRequest(DioException error) async {
    final String? accessToken = await _authTokenStore.readAccessToken();

    final Options clonedOptions = Options(
      method: error.requestOptions.method,
      headers: <String, dynamic>{
        ...error.requestOptions.headers,
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      contentType: error.requestOptions.contentType,
      extra: error.requestOptions.extra,
      followRedirects: error.requestOptions.followRedirects,
      listFormat: error.requestOptions.listFormat,
      maxRedirects: error.requestOptions.maxRedirects,
      receiveDataWhenStatusError: error.requestOptions.receiveDataWhenStatusError,
      receiveTimeout: error.requestOptions.receiveTimeout,
      requestEncoder: error.requestOptions.requestEncoder,
      responseDecoder: error.requestOptions.responseDecoder,
      responseType: error.requestOptions.responseType,
      sendTimeout: error.requestOptions.sendTimeout,
      validateStatus: error.requestOptions.validateStatus,
    );

    return _dio.request(
      '${error.requestOptions.baseUrl}${error.requestOptions.path}',
      data: error.requestOptions.data,
      queryParameters: error.requestOptions.queryParameters,
      cancelToken: error.requestOptions.cancelToken,
      onReceiveProgress: error.requestOptions.onReceiveProgress,
      onSendProgress: error.requestOptions.onSendProgress,
      options: clonedOptions,
    );
  }
}
