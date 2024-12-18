class AdminUser {
  final String id;
  final String email;
  final String name;
  final List<String> permissions;

  AdminUser({
    required this.id,
    required this.email,
    required this.name,
    required this.permissions,
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      permissions: List<String>.from(json['permissions'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'permissions': permissions,
    };
  }
}
