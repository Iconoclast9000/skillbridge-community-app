import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashReportingService {
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  static Future<void> initialize() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = (FlutterErrorDetails details) {
      _crashlytics.recordFlutterError(details);
    };
  }

  static Future<void> recordError({
    required dynamic error,
    required StackTrace stackTrace,
    String? reason,
  }) async {
    await _crashlytics.recordError(
      error,
      stackTrace,
      reason: reason,
    );
  }

  static Future<void> setUserIdentifier(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }

  static Future<void> log(String message) async {
    await _crashlytics.log(message);
  }

  static Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value);
  }
}
