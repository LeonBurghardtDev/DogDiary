/// Represents a dog that is tracked in the diary app.
class Dog {
  final String id;
  final String name;
  final String breed;
  final String birthDate;

  Dog({
    required this.id,
    required this.name,
    required this.breed,
    required this.birthDate,
  });

  /// Converts a Dog instance into a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'birthDate': birthDate,
    };
  }

  /// Creates a Dog instance from a JSON map.
  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'],
      name: json['name'],
      breed: json['breed'],
      birthDate: json['birthDate'],
    );
  }
}
