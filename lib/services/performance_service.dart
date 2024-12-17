import 'package:firebase_performance/firebase_performance.dart';

class PerformanceService {
  static final FirebasePerformance _performance = FirebasePerformance.instance;

  static Future<void> startTrace(String traceName) async {
    final trace = await _performance.newTrace(traceName);
    await trace.start();
  }

  static Future<void> stopTrace(String traceName) async {
    final trace = await _performance.newTrace(traceName);
    await trace.stop();
  }

  static Future<void> recordMetric({
    required String traceName,
    required String metricName,
    required int value,
  }) async {
    final trace = await _performance.newTrace(traceName);
    await trace.putMetric(metricName, value);
  }

  static HttpMetric? startHttpMetric(String url, String method) {
    try {
      return _performance.newHttpMetric(url, HttpMethod.Get);
    } catch (e) {
      print('Error starting HTTP metric: $e');
      return null;
    }
  }

  static Future<void> stopHttpMetric(HttpMetric? metric) async {
    if (metric != null) {
      try {
        await metric.stop();
      } catch (e) {
        print('Error stopping HTTP metric: $e');
      }
    }
  }
}
