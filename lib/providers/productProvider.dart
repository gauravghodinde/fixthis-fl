import 'package:fixthis/model/productlist.dart';
import 'package:flutter/material.dart';

class ProductListProvider extends ChangeNotifier {
  ProductList _ProductList = ProductList(
    Productlist: [],
  );

  ProductList get Productlist => _ProductList;

  void setProductList(String Productlist) {
    _ProductList = ProductList.fromJson(Productlist);
    notifyListeners();
  }

  void setProductListFromModel(ProductList Productlist) {
    _ProductList = Productlist;
    notifyListeners();
  }
}
