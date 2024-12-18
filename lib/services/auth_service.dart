import 'package:shared_preferences.dart';
import '../core/utils/secure_storage.dart';

class AuthService {
  final SharedPreferences _prefs;

  AuthService(this._prefs);

  Future<bool> signIn(String email, String password) async {
    try {
      // For demo purposes only - in production, use proper authentication
      if (email == 'admin@test.com' && password == 'admin123') {
        await _prefs.setString('user_email', email);
        await SecureStorage.saveToken('dummy_token');
        return true;
      }
      return false;
    } catch (e) {
      print('Sign in error: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    await _prefs.remove('user_email');
    await SecureStorage.deleteToken();
  }

  bool isSignedIn() {
    return _prefs.getString('user_email') != null;
  }
}
