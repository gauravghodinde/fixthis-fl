// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RepairRequest {
  final String id;
  final String categoryId;
  final String productId;
  final String userId;
  final String pickupAddress;
  final String deliveryAddress;
  final String image;
  final String description;
  final String status;
  final String dateTime;
  final String createdAt;
  final String updatedAt;

  RepairRequest({
    required this.id,
    required this.categoryId,
    required this.productId,
    required this.userId,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.image,
    required this.description,
    required this.status,
    required this.dateTime,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'productId': productId,
      'userId': userId,
      'pickupAddress': pickupAddress,
      'deliveryAddress': deliveryAddress,
      'image': image,
      'description': description,
      'status': status,
      'dateTime': dateTime,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory RepairRequest.fromMap(Map<String, dynamic> map) {
    return RepairRequest(
      id: map['_id'] as String,
      categoryId: map['categoryId'] as String,
      productId: map['productId'] as String,
      userId: map['userId'] as String,
      pickupAddress: map['pickupAddress'] as String,
      deliveryAddress: map['deliveryAddress'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      dateTime: map['dateTime'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RepairRequest.fromJson(String source) =>
      RepairRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
