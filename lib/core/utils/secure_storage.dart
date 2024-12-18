import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'admin_token', value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'admin_token');
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: 'admin_token');
  }

  static Future<void> saveCredentials(String username, String password) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
  }

  static Future<Map<String, String?>> getCredentials() async {
    final username = await _storage.read(key: 'username');
    final password = await _storage.read(key: 'password');
    return {
      'username': username,
      'password': password,
    };
  }

  static Future<void> deleteCredentials() async {
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'password');
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
