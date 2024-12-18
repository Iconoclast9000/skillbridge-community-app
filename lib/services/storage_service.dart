import 'package:shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static const String _lastLoginKey = 'last_login';
  static const String _userPreferencesKey = 'user_preferences';
  static const String _themeKey = 'theme_mode';

  static Future<void> saveLastLogin(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastLoginKey, time.toIso8601String());
  }

  static Future<DateTime?> getLastLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final dateStr = prefs.getString(_lastLoginKey);
    return dateStr != null ? DateTime.parse(dateStr) : null;
  }

  static Future<void> saveUserPreferences(Map<String, dynamic> preferences) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userPreferencesKey, json.encode(preferences));
  }

  static Future<Map<String, dynamic>> getUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsStr = prefs.getString(_userPreferencesKey);
    return prefsStr != null 
      ? json.decode(prefsStr) as Map<String, dynamic>
      : {};
  }

  static Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.toString());
  }

  static Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final modeStr = prefs.getString(_themeKey);
    switch (modeStr) {
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
