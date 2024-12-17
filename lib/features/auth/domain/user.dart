class User {
  final String id;
  final String name;
  final String email;
  final List<String> skills;
  final List<String> interests;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.skills = const [],
    this.interests = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'skills': skills,
    'interests': interests,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    skills: List<String>.from(json['skills'] ?? []),
    interests: List<String>.from(json['interests'] ?? []),
  );
}