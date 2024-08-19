import 'package:fixthis/model/product.dart';
import 'package:fixthis/pages/addrepairRequestpage.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      // required this.imageLink,
      // required this.ProductName,
      required this.CategorytName,
      required this.product});
  // final String imageLink;
  // final String ProductName;
  final String CategorytName;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddRepairRequest(
                      product: product,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     Colors.black.withOpacity(0.0),
            //     Colors.black.withOpacity(0.1),
            //   ],
            // ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.5),
            //     blurRadius: .0,
            //     offset: Offset(0, 4),
            //   ),
            // ],
            // color: Colors.black38,
            borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                fit: BoxFit.contain,
                product.image,
                width: 150,
                height: 150,
              ),
              Text(
                product.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                CategorytName,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
