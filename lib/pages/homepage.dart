import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixthis/components/appbar.dart';
import 'package:fixthis/components/categorycard.dart';
import 'package:fixthis/components/productcard.dart';
import 'package:fixthis/components/searchbar.dart';
import 'package:fixthis/model/category.dart';
import 'package:fixthis/model/categorylist.dart';
import 'package:fixthis/model/product.dart';
import 'package:fixthis/pages/loaction_selector_page.dart';
import 'package:fixthis/pages/searchpage.dart';
import 'package:fixthis/providers/categoryProvider.dart';
import 'package:fixthis/providers/productProvider.dart';
import 'package:fixthis/providers/userProvider.dart';
import 'package:fixthis/services/auth_services.dart';
import 'package:fixthis/utils/constants.dart';
import 'package:fixthis/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _stretch = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print("Home in");
    _fetchCategories();
    _fetchProducts();
    print("homed  ");
  }

  // Future<void> fetchCategories() async {
  //   final response =
  //       await http.get(Uri.parse('http://localhost:3000/category/getall'));

  //   print('Response status: ${response.statusCode}');
  //   print('responseponse body: ${response.body}');
  //   if (response.statusCode < 300) {
  //     List jsonResponse = json.decode(response.body);
  //     setState(() {
  //       _categories =
  //           jsonResponse.map((data) => Category.fromJson(data)).toList();
  //       _isLoading = false;
  //     });
  //   } else {
  //     throw Exception('Failed to load categories');
  //   }
  // }

  void _fetchCategories() async {
    var categoryListProvider =
        Provider.of<CategoryListProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('${Constants.uri}/category/getall'),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      print('Response array: ${jsonEncode(jsonDecode(res.body)['body'])}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // List jsonResponse = json.decode(res.body);
          categoryListProvider.setCategoryList(res.body);
          setState(() {
            // _categories =
            //     jsonResponse.map((data) => Category.fromJson(data)).toList();
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, " error ?? ${e.toString()}");
    }
  }

  void _fetchProducts() async {
    var productListProvider =
        Provider.of<ProductListProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('${Constants.uri}/product/getall'),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      print('Response array: ${jsonEncode(jsonDecode(res.body)['body'])}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // List jsonResponse = json.decode(res.body);
          productListProvider.setProductList(res.body);
          setState(() {
            // _categories =
            //     jsonResponse.map((data) => Category.fromJson(data)).toList();
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, " error ?? ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final _categories = Provider.of<CategoryListProvider>(context).categorylist;
    final _products = Provider.of<ProductListProvider>(context).Productlist;
    // print(_categories);
    AuthService authService = AuthService();
    final List<String> items = List.generate(20, (index) => 'Item $index');
    void _logout() {
      authService.SignOut(context);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            // Location AppBar
            locationAppBar(),
            // Search Bar
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      // useSafeArea: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return SearchPage();
                      },
                    );
                  },
                  child: SearchBarHome(
                    hintText: "search for trimer",
                  ),
                ),
              ),
            ),

            // Ad Carousel
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: [
                    Container(
                      width: 5000,
                      height: 400,
                      color: Colors.red,
                      child: Center(child: Text("1")),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Center(child: Text("2")),
                    ),
                    Container(
                      color: Colors.green,
                      child: Center(child: Text("3")),
                    ),
                  ],
                ),
              ),
            ),

            // Horizontal Scroll View
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Categories for repairs",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      for (var i = 0;
                          i < _categories.categorylist.length;
                          i += 2)
                        Column(
                          children: [
                            CategoryCard(
                              // imageLink: _categories.categorylist[i].image,
                              // categoryName: _categories.categorylist[i].name,
                              category: Category(
                                  id: _categories.categorylist[i].id,
                                  name: _categories.categorylist[i].name,
                                  image: _categories.categorylist[i].image),
                            ),
                            if (_categories.categorylist.length > i + 1)
                              CategoryCard(
                                category: Category(
                                    id: _categories.categorylist[i + 1].id,
                                    name: _categories.categorylist[i + 1].name,
                                    image:
                                        _categories.categorylist[i + 1].image),
                                // imageLink:
                                //     _categories.categorylist[i + 1].image,
                                // categoryName:
                                //     _categories.categorylist[i + 1].name
                              ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Products for repairs",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // List
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < _categories.categorylist.length; i++)
                        Wrap(
                          children: [
                            for (int j = 0;
                                j < _products.Productlist.length;
                                j++)
                              if (_products.Productlist[j].categoryId ==
                                  _categories.categorylist[i].id)
                                ProductCard(
                                  imageLink: _products.Productlist[j].image,
                                  ProductName: _products.Productlist[j].name,
                                  CategorytName:
                                      _categories.categorylist[i].name,
                                ),
                          ],
                        )
                      // Column(
                      //   children: [
                      //     CategoryCard(
                      //         imageLink: _products.Productlist[i].image,
                      //         categoryName: _products.Productlist[i].name),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       return Container(
            //         color: index.isOdd ? Colors.white : Colors.black12,
            //         height: 100.0,
            //         child: Center(
            //           child: Text(
            //             '$index',
            //           ),
            //         ),
            //       );
            //     },
            //     childCount: 20,
            //   ),
            // ),
          ],
        ),
      ),
      
    );
  }
}
