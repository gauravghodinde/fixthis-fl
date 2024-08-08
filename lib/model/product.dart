// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String id;
  final String categoryId;
  final String name;
  final String image;

  Product({
    required this.categoryId,
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      categoryId: map['categoryId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
