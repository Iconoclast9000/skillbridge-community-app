import 'package:shared_preferences.dart';

class AuthService {
  final SharedPreferences _prefs;

  AuthService(this._prefs);

  Future<bool> signIn(String email, String password) async {
    try {
      // For testing purposes, accept any email/password combination
      if (email.isNotEmpty && password.isNotEmpty) {
        await _prefs.setString('user_email', email);
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
  }

  bool isSignedIn() {
    return _prefs.getString('user_email') != null;
  }
}
