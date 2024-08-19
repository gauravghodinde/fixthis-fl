import 'package:fixthis/components/productcard.dart';
import 'package:fixthis/model/product.dart';
import 'package:fixthis/providers/productProvider.dart';
import 'package:fixthis/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController controller;
  Product _SelectedProduct =
      Product(categoryId: "", id: "", name: "", image: "");

  // @override
  // void initState() {
  //   super.initState();
  //   controller = TextEditingController();
  // }

  @override
  Widget build(BuildContext context) {
    List<Product> _products =
        Provider.of<ProductListProvider>(context).Productlist.Productlist;

    return Container(
      color: Colors.white,
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Autocomplete<Product>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<Product>.empty();
                    }
                    return _products.where(
                      (Product option) {
                        return option.name
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      },
                    );
                    // .map((Product option) => option.name);
                  },
                  onSelected: (Product selection) {
                    debugPrint('You just selected ${selection.name}');
                    // _SelectedProduct = selection;
                    setState(() {
                      _SelectedProduct = selection;
                      controller.text = "";
                    });
                  },

                  //decoration
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    this.controller = controller;

                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        hintText: "Search Something",
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(Constants.mainColorHsh),
                          size: 24,
                        ),
                      ),
                    );
                  },
                  optionsViewBuilder:
                      (context, Function(Product) onSelected, options) {
                    return Material(
                      elevation: 4,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);

                          return ListTile(
                            // title: Text(option.toString()),
                            title: SubstringHighlight(
                              text: option.name.toString(),
                              term: controller.text,
                              textStyleHighlight:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            // subtitle: Text("This is subtitle"),
                            onTap: () {
                              onSelected(option);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: options.length,
                      ),
                    );
                  },
                ),
              ),
              if (_SelectedProduct.categoryId != "")
                ProductCard(
                    // imageLink: _SelectedProduct.image,
                    // ProductName: _SelectedProduct.name,
                    product: _SelectedProduct,
                    CategorytName: "")
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Column(
              //     children: [
              //       Text('Selected Product:'),
              //       Text('Name: ${_SelectedProduct!.name}'),+
              //       Text('ID: ${_SelectedProduct!.id}'),
              //       Text('Category ID: ${_SelectedProduct!.categoryId}'),
              //       Image.network(_SelectedProduct!.image),
              //     ],
              //   ),
              // ),
            ],
          )),
    );
  }
}
