import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/admin_user.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  AdminUser? _adminUser;
  bool _loading = false;

  AdminUser? get adminUser => _adminUser;
  bool get loading => _loading;

  Future<bool> signInAdmin(String email, String password) async {
    _loading = true;
    notifyListeners();

    try {
      final admin = await _authService.signInAdmin(email, password);
      _adminUser = admin;
      _loading = false;
      notifyListeners();
      return admin != null;
    } catch (e) {
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _adminUser = null;
    notifyListeners();
  }

  Future<bool> checkAdminStatus() async {
    _loading = true;
    notifyListeners();

    try {
      final hasAccess = await _authService.hasAdminAccess();
      _loading = false;
      notifyListeners();
      return hasAccess;
    } catch (e) {
      _loading = false;
      notifyListeners();
      return false;
    }
  }
}
