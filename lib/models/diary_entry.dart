class DiaryEntry {
  final String id;
  final String diaryId;
  final String description;
  final String mood;
  final String imagePath;
  final DateTime createdAt;

  DiaryEntry({
    required this.id,
    required this.diaryId,
    required this.description,
    required this.mood,
    required this.imagePath,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'diaryId': diaryId,
      'description': description,
      'mood': mood,
      'imagePath': imagePath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'],
      diaryId: json['diaryId'],
      description: json['description'],
      mood: json['mood'],
      imagePath: json['imagePath'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
