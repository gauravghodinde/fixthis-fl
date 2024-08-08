// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fixthis/model/product.dart';

class ProductList {
  final List<Product> Productlist;

  ProductList({required this.Productlist});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Productlist': Productlist.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductList.fromMap(Map<String, dynamic> map) {
    return ProductList(
      Productlist: List<Product>.from(
        (map['body'] as List<dynamic>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductList.fromJson(String source) =>
      ProductList.fromMap(json.decode(source) as Map<String, dynamic>);
}
