// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String city;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["_id"] as String,
      name: map["name"] as String,
      email: map["email"] as String,
      phoneNumber: map["phoneNumber"] as String,
      city: map["city"] as String,
      password: map["password"] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
