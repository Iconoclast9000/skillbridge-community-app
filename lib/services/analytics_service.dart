import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logAdminLogin(String adminId) async {
    await _analytics.logEvent(
      name: 'admin_login',
      parameters: {
        'admin_id': adminId,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  static Future<void> logAdminAction({
    required String adminId,
    required String action,
    required String targetType,
    String? targetId,
  }) async {
    await _analytics.logEvent(
      name: 'admin_action',
      parameters: {
        'admin_id': adminId,
        'action': action,
        'target_type': targetType,
        'target_id': targetId,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  static Future<void> logError({
    required String error,
    required String screenName,
    String? additionalInfo,
  }) async {
    await _analytics.logEvent(
      name: 'app_error',
      parameters: {
        'error': error,
        'screen': screenName,
        'info': additionalInfo,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  static Future<void> setUserProperties({
    required String userId,
    required String userRole,
  }) async {
    await _analytics.setUserId(id: userId);
    await _analytics.setUserProperty(name: 'user_role', value: userRole);
  }
}
