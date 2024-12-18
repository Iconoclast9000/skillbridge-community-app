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
}
