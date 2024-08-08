// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fixthis/model/category.dart';

class CategoryList {
  final List<Category> categorylist;

  CategoryList({required this.categorylist});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categorylist': categorylist.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryList.fromMap(Map<String, dynamic> map) {
    return CategoryList(
      categorylist: List<Category>.from(
        (map['body'] as List<dynamic>).map<Category>(
          (x) => Category.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryList.fromJson(String source) =>
      CategoryList.fromMap(json.decode(source) as Map<String, dynamic>);
}
