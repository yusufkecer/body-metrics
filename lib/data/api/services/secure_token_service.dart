import 'package:bodymetrics/core/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SecureTokenServiceBase)
final class SecureTokenService implements SecureTokenServiceBase {
  final _storage = const FlutterSecureStorage();

  static const _tokenKey = 'jwt_token';
  static const _emailKey = 'email';

  @override
  Future<void> saveSession({
    required String token,
    required String email,
  }) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _emailKey, value: email);
  }

  @override
  Future<String?> getToken() async => _storage.read(key: _tokenKey);

  @override
  Future<String?> getEmail() async => _storage.read(key: _emailKey);

  @override
  Future<void> clearSession() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _emailKey);
  }
}
