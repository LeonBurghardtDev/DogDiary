/// Represents a diary associated with a specific dog.
class Diary {
  final String id;
  final String dogId;
  final String title;
  final DateTime createdAt;

  Diary({
    required this.id,
    required this.dogId,
    required this.title,
    required this.createdAt,
  });

  /// Converts a Diary instance into a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dogId': dogId,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Creates a Diary instance from a JSON map.
  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      id: json['id'],
      dogId: json['dogId'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  get imagePath => null;
}
