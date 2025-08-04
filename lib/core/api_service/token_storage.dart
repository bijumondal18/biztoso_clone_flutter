import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenStorage {
  Future<void> saveToken(String token);
  Future<String?> readToken();
  Future<void> clearToken();
}

class SecureTokenStorage implements TokenStorage {
  final _storage = const FlutterSecureStorage();
  final _key = 'access_token';

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  @override
  Future<String?> readToken() async {
    return await _storage.read(key: _key);
  }

  @override
  Future<void> clearToken() async {
    await _storage.delete(key: _key);
  }
}