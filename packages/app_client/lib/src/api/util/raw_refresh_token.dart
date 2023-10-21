import 'dart:developer';

import 'package:dio/dio.dart';

import '../type/auth_payload_type.dart';

Future<AuthPayloadType?> rawRefreshToken(
  Dio dio, {
  required String baseUrl,
  required String refreshToken,
}) async {
  const refreshTokenMutation = r'''
    mutation RefreshToken {
      refreshToken(input: { refreshToken: $refreshToken }) {
        accessToken
        hasEmailVerified
        refreshToken
    }
  }
  ''';

  try {
    final res = await dio.post(
      '$baseUrl/graphql',
      data: {
        'query': refreshTokenMutation,
        'variables': {
          'refreshToken': refreshToken,
        }
      },
    );

    if (res.data == null || res.data is! Map<String, dynamic>) {
      return null;
    }

    return AuthPayloadType.fromJson(res.data);
  } catch (e) {
    log('Error refreshing token', error: e);
  }

  return null;
}
