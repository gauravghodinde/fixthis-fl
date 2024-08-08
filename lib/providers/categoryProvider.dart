import 'package:fixthis/model/categorylist.dart';
import 'package:flutter/material.dart';

class CategoryListProvider extends ChangeNotifier {
  CategoryList _categoryList = CategoryList(
    categorylist: [],
  );

  CategoryList get categorylist => _categoryList;

  void setCategoryList(String categorylist) {
    _categoryList = CategoryList.fromJson(categorylist);
    notifyListeners();
  }

  void setCategoryListFromModel(CategoryList categorylist) {
    _categoryList = categorylist;
    notifyListeners();
  }
}
