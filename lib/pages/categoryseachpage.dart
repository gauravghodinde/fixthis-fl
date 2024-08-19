import 'package:fixthis/components/productcard.dart';
import 'package:fixthis/model/category.dart';
import 'package:fixthis/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySearchPage extends StatelessWidget {
  final Category category;
  const CategorySearchPage({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    final _products = Provider.of<ProductListProvider>(context).Productlist;

    return Container(
      color: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 65, 8, 8),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (int j = 0; j < _products.Productlist.length; j++)
                  if (_products.Productlist[j].categoryId == category.id)
                    ProductCard(
                      // imageLink: _products.Productlist[j].image,
                      // ProductName: _products.Productlist[j].name,
                      product: _products.Productlist[j],
                      CategorytName: category.name,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
