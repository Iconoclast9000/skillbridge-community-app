import 'package:firebase_auth/firebase_auth.dart';
import '../services/analytics_service.dart';

class SessionService {
  static const int _sessionTimeout = 30; // minutes
  static DateTime? _lastActivity;

  static void updateLastActivity() {
    _lastActivity = DateTime.now();
  }

  static bool isSessionExpired() {
    if (_lastActivity == null) return true;
    
    final difference = DateTime.now().difference(_lastActivity!);
    return difference.inMinutes >= _sessionTimeout;
  }

  static Future<void> checkSession(String userId) async {
    if (isSessionExpired()) {
      await AnalyticsService.logAdminAction(
        adminId: userId,
        action: 'session_timeout',
        targetType: 'session',
      );
      await FirebaseAuth.instance.signOut();
    }
  }

  static void startSession() {
    updateLastActivity();
  }

  static Future<void> endSession(String userId) async {
    await AnalyticsService.logAdminAction(
      adminId: userId,
      action: 'session_end',
      targetType: 'session',
    );
    _lastActivity = null;
  }
}
