import 'dart:convert';

class AdminUser {
  final String id;
  final String username;
  final DateTime lastLogin;

  AdminUser({
    required this.id,
    required this.username,
    required this.lastLogin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'lastLogin': lastLogin.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  factory AdminUser.fromJson(String source) => 
      AdminUser.fromMap(json.decode(source) as Map<String, dynamic>);

  factory AdminUser.fromMap(Map<String, dynamic> map) {
    return AdminUser(
      id: map['id'] as String,
      username: map['username'] as String,
      lastLogin: DateTime.parse(map['lastLogin'] as String),
    );
  }
}
