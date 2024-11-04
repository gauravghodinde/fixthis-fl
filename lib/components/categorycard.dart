import 'package:fixthis/model/category.dart';
import 'package:fixthis/pages/categoryseachpage.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          // useSafeArea: true,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return CategorySearchPage(
              category: category,
            );
          },
        );
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                category.image,
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
              ),
              Text(
                category.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
