import 'package:shared_preferences.dart';
import 'dart:convert';

class CacheMiddleware {
  static const String _userCacheKey = 'cached_users';
  static const String _skillCacheKey = 'cached_skills';
  static const Duration _cacheExpiration = Duration(hours: 1);

  static Future<void> cacheUsers(List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = {
      'timestamp': DateTime.now().toIso8601String(),
      'data': users,
    };
    await prefs.setString(_userCacheKey, json.encode(cacheData));
  }

  static Future<List<Map<String, dynamic>>?> getCachedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedString = prefs.getString(_userCacheKey);

    if (cachedString != null) {
      final cached = json.decode(cachedString);
      final timestamp = DateTime.parse(cached['timestamp']);

      if (DateTime.now().difference(timestamp) < _cacheExpiration) {
        return List<Map<String, dynamic>>.from(cached['data']);
      }
    }
    return null;
  }

  static Future<void> cacheSkills(List<Map<String, dynamic>> skills) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = {
      'timestamp': DateTime.now().toIso8601String(),
      'data': skills,
    };
    await prefs.setString(_skillCacheKey, json.encode(cacheData));
  }

  static Future<List<Map<String, dynamic>>?> getCachedSkills() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedString = prefs.getString(_skillCacheKey);

    if (cachedString != null) {
      final cached = json.decode(cachedString);
      final timestamp = DateTime.parse(cached['timestamp']);

      if (DateTime.now().difference(timestamp) < _cacheExpiration) {
        return List<Map<String, dynamic>>.from(cached['data']);
      }
    }
    return null;
  }

  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userCacheKey);
    await prefs.remove(_skillCacheKey);
  }
}
