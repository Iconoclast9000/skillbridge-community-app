import 'package:flutter/material.dart';
import 'package:shared_preferences.dart';
import '../../models/admin_user.dart';
import '../../core/utils/secure_storage.dart';

class AdminAuthController extends ChangeNotifier {
  final SharedPreferences _prefs;
  bool _isAuthenticated = false;
  AdminUser? _currentAdmin;

  AdminAuthController(this._prefs) {
    _initializeAuth();
  }

  bool get isAuthenticated => _isAuthenticated;
  AdminUser? get currentAdmin => _currentAdmin;

  Future<void> _initializeAuth() async {
    try {
      final token = await SecureStorage.getToken();
      if (token != null) {
        _isAuthenticated = true;
        _currentAdmin = _loadAdminData();
        notifyListeners();
      }
    } catch (e) {
      await logout();
    }
  }

  AdminUser? _loadAdminData() {
    final adminJson = _prefs.getString('admin_data');
    if (adminJson != null) {
      return AdminUser.fromJson(adminJson);
    }
    return null;
  }

  Future<bool> login(String username, String password) async {
    try {
      if (username == 'admin' && password == 'admin123') {
        final admin = AdminUser(
          id: '1',
          username: username,
          lastLogin: DateTime.now(),
        );

        await SecureStorage.saveToken('dummy_token');
        await _prefs.setString('admin_data', admin.toJson());
        
        _isAuthenticated = true;
        _currentAdmin = admin;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await SecureStorage.deleteToken();
      await _prefs.remove('admin_data');
      _isAuthenticated = false;
      _currentAdmin = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  Future<bool> changePassword(String currentPassword, String newPassword) async {
    try {
      // In a real app, validate against backend
      if (currentPassword == 'admin123') {
        // Here you would update the password in your backend
        // For demo, we'll just return success
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Change password error: $e');
      return false;
    }
  }
}
