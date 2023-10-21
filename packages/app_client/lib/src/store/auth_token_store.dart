abstract interface class AuthTokenStore {
  Future<void> writeAccessToken(String accessToken);

  Future<void> writeRefreshToken(String refreshToken);

  Future<String?> readAccessToken();

  Future<String?> readRefreshToken();

  Future<bool> hasRefreshToken();

  Future<void> clear();
}
