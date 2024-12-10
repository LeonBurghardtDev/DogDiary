class Diary {
  final String id;
  final String dogId;
  final String title;
  final DateTime createdAt;
  final String? imagePath;

  Diary({
    required this.id,
    required this.dogId,
    required this.title,
    required this.createdAt,
    this.imagePath,
  });

  Diary copyWith({
    String? id,
    String? dogId,
    String? title,
    DateTime? createdAt,
    String? imagePath,
  }) {
    return Diary(
      id: id ?? this.id,
      dogId: dogId ?? this.dogId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dogId': dogId,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'imagePath': imagePath,
    };
  }

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      id: json['id'],
      dogId: json['dogId'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      imagePath: json['imagePath'],
    );
  }
}
