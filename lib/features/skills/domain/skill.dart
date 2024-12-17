class Skill {
  final String id;
  final String userId;
  final String title;
  final String description;
  final List<String> categories;
  final int durationMinutes;

  Skill({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.categories = const [],
    this.durationMinutes = 30,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'description': description,
    'categories': categories,
    'durationMinutes': durationMinutes,
  };

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    id: json['id'],
    userId: json['userId'],
    title: json['title'],
    description: json['description'],
    categories: List<String>.from(json['categories'] ?? []),
    durationMinutes: json['durationMinutes'] ?? 30,
  );
}