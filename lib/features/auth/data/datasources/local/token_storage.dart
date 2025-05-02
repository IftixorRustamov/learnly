import 'package:kursol/core/database/hive_initializer.dart';

class TokenStorage {
  static const String _boxName = 'auth_tokens';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  Future<void> init() async {
    await HiveInitializer.openBox(_boxName);
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final box = HiveInitializer.getBox(_boxName);
    await box.put(_accessTokenKey, accessToken);
    await box.put(_refreshTokenKey, refreshToken);
  }

  Future<String?> getAccessToken() async {
    final box = HiveInitializer.getBox(_boxName);
    return box.get(_accessTokenKey) as String?;
  }

  Future<String?> getRefreshToken() async {
    final box = HiveInitializer.getBox(_boxName);
    return box.get(_refreshTokenKey) as String?;
  }

  Future<void> clearTokens() async {
    final box = HiveInitializer.getBox(_boxName);
    await box.delete(_accessTokenKey);
    await box.delete(_refreshTokenKey);
  }
}
