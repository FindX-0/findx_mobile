final class AuthPayloadType {
  factory AuthPayloadType.fromJson(Map<String, dynamic> json) {
    return AuthPayloadType._(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
  AuthPayloadType._({required this.accessToken, required this.refreshToken});

  final String? accessToken;
  final String? refreshToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthPayloadType &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          refreshToken == other.refreshToken;

  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @override
  String toString() => 'AuthPayload{accessToken: $accessToken, refreshToken: $refreshToken}';
}
