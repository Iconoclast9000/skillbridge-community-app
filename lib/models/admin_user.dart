class AdminUser {
  final String id;
  final String username;
  final DateTime lastLogin;

  AdminUser({
    required this.id,
    required this.username,
    required this.lastLogin,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'lastLogin': lastLogin.toIso8601String(),
      };

  factory AdminUser.fromJson(Map<String, dynamic> json) => AdminUser(
        id: json['id'] as String,
        username: json['username'] as String,
        lastLogin: DateTime.parse(json['lastLogin'] as String),
      );
}
