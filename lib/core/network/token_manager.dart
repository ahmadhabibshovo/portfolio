import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenManager {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
  bool get hasToken;
}

class TokenManagerImpl implements TokenManager {
  static const _keyAccessToken = 'auth_access_token';
  static const _keyRefreshToken = 'auth_refresh_token';

  final SharedPreferences prefs;
  String? _cachedAccessToken;

  TokenManagerImpl({required this.prefs}) {
    _cachedAccessToken = prefs.getString(_keyAccessToken);
  }

  @override
  bool get hasToken =>
      _cachedAccessToken != null && _cachedAccessToken!.isNotEmpty;

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _cachedAccessToken = accessToken;
    await prefs.setString(_keyAccessToken, accessToken);
    await prefs.setString(_keyRefreshToken, refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    _cachedAccessToken ??= prefs.getString(_keyAccessToken);
    return _cachedAccessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    return prefs.getString(_keyRefreshToken);
  }

  @override
  Future<void> clearTokens() async {
    _cachedAccessToken = null;
    await prefs.remove(_keyAccessToken);
    await prefs.remove(_keyRefreshToken);
  }
}
