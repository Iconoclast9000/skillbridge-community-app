import 'package:crypto/crypto.dart';
import 'dart:convert';

class SecurityUtils {
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static String generateSessionId() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    final bytes = utf8.encode(random);
    final digest = md5.convert(bytes);
    return digest.toString();
  }

  static bool isStrongPassword(String password) {
    if (password.length < 8) return false;

    bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowerCase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasUpperCase && hasLowerCase && hasDigits && hasSpecialCharacters;
  }

  static String maskEmail(String email) {
    if (email.isEmpty) return '';
    
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final username = parts[0];
    final domain = parts[1];

    final maskedUsername = username.length > 2
        ? '${username[0]}${'*' * (username.length - 2)}${username[username.length - 1]}'
        : username;

    return '$maskedUsername@$domain';
  }

  static void validateInput(String input) {
    // Check for common security vulnerabilities
    final maliciousPatterns = [
      RegExp(r'<script>'),
      RegExp(r'javascript:'),
      RegExp(r'\b(union|select|insert|delete|drop)\b', caseSensitive: false),
    ];

    for (var pattern in maliciousPatterns) {
      if (pattern.hasMatch(input)) {
        throw Exception('Invalid input detected');
      }
    }
  }
}
