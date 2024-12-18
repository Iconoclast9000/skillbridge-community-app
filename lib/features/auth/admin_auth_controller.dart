import 'package:flutter/material.dart';
import 'package:shared_preferences.dart';

class AdminAuthController extends ChangeNotifier {
  final SharedPreferences _prefs;
  bool _isAuthenticated = false;

  AdminAuthController(this._prefs) {
    _isAuthenticated = _prefs.getBool('isAdminAuthenticated') ?? false;
  }

  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String username, String password) async {
    // In a real app, this would validate against a secure backend
    if (username == 'admin' && password == 'admin123') {
      _isAuthenticated = true;
      await _prefs.setBool('isAdminAuthenticated', true);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    await _prefs.setBool('isAdminAuthenticated', false);
    notifyListeners();
  }
}
