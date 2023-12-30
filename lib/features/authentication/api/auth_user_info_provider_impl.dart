import 'package:findx_dart_client/app_client.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/logger.dart';
import '../../../shared/util/jwt_decoder.dart';
import 'auth_user_info_provider.dart';

@LazySingleton(as: AuthUserInfoProvider)
class AuthUserInfoProviderImpl implements AuthUserInfoProvider {
  AuthUserInfoProviderImpl(
    this._authTokenStore,
  );

  final AuthTokenStore _authTokenStore;

  @override
  Future<String?> getId() async {
    final refreshToken = await _authTokenStore.readRefreshToken();

    if (refreshToken == null) {
      return null;
    }

    try {
      final payload = JwtDecoder.parseJwt(refreshToken);

      if (!payload.containsKey('userId')) {
        return null;
      }

      return payload['userId'] as String?;
    } catch (e) {
      logger.e(e);
    }

    return null;
  }
}
