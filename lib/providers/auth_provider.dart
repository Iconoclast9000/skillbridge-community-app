import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/analytics_service.dart';
import '../services/performance_service.dart';
import '../services/crash_reporting_service.dart';
import '../models/admin_user.dart';
import '../middleware/auth_middleware.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  AdminUser? _adminUser;
  bool _loading = false;
  String? _error;

  AdminUser? get adminUser => _adminUser;
  bool get loading => _loading;
  String? get error => _error;
  bool get isAuthenticated => _adminUser != null;

  Future<bool> signInAdmin(String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await PerformanceService.startTrace('admin_login');

      final admin = await _authService.signInAdmin(email, password);
      
      if (admin != null) {
        final isValidAdmin = await AuthMiddleware.isValidAdmin(admin.id);
        
        if (isValidAdmin) {
          _adminUser = admin;
          await AnalyticsService.logAdminLogin(admin.id);
          await AnalyticsService.setUserProperties(
            userId: admin.id,
            userRole: 'admin',
          );
          await CrashReportingService.setUserIdentifier(admin.id);
        } else {
          _error = 'User does not have admin privileges';
          await _authService.signOut();
        }
      } else {
        _error = 'Invalid credentials';
      }
    } catch (e, stackTrace) {
      _error = 'An error occurred during login';
      await AnalyticsService.logError(
        error: e.toString(),
        screenName: 'AdminLogin',
      );
      await CrashReportingService.recordError(
        error: e,
        stackTrace: stackTrace,
        reason: 'Error during admin login',
      );
    } finally {
      await PerformanceService.stopTrace('admin_login');
      _loading = false;
      notifyListeners();
    }

    return isAuthenticated;
  }

  Future<void> signOut() async {
    try {
      if (_adminUser != null) {
        await AnalyticsService.logAdminAction(
          adminId: _adminUser!.id,
          action: 'logout',
          targetType: 'session',
        );
      }
      await _authService.signOut();
      _adminUser = null;
    } catch (e, stackTrace) {
      await CrashReportingService.recordError(
        error: e,
        stackTrace: stackTrace,
        reason: 'Error during sign out',
      );
    }
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        final isValidAdmin = await AuthMiddleware.isValidAdmin(currentUser.uid);
        if (!isValidAdmin) {
          await signOut();
        }
      }
    } catch (e, stackTrace) {
      await CrashReportingService.recordError(
        error: e,
        stackTrace: stackTrace,
        reason: 'Error checking auth status',
      );
      await signOut();
    }
  }

  Stream<bool> get authStateChanges => _authService.authStateChanges()
    .map((user) => user != null);
}
