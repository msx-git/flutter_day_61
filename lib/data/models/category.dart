class Kategory {
  final num id;
  final String name;
  final String image;
  final String creationAt;
  final String updatedAt;

  Kategory({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'Category{id: $id, name: $name, image: $image, creationAt: $creationAt, updatedAt: $updatedAt}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
    };
  }

  factory Kategory.fromJson(Map<String, dynamic> json) {
    return Kategory(
      id: json['id'] as num,
      name: json['name'] as String,
      image: json['image'] as String,
      creationAt: json['creationAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}
