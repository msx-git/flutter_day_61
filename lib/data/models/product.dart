import 'category.dart';

class Product {
  final num id;
  final String title;
  final num price;
  final String description;
  final List<dynamic> images;
  final String creationAt;
  final String updatedAt;
  final Kategory category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'images': images,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
      'category': category,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      images: json['images'],
      creationAt: json['creationAt'] as String,
      updatedAt: json['updatedAt'] as String,
      category: Kategory.fromJson(json['category']),
    );
  }
}
