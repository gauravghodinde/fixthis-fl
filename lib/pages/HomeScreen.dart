import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixthis/components/appbar.dart';
import 'package:fixthis/components/categorycard.dart';
import 'package:fixthis/components/productcard.dart';
import 'package:fixthis/components/searchbar.dart';
import 'package:fixthis/model/category.dart';
import 'package:fixthis/pages/searchpage.dart';
import 'package:fixthis/providers/categoryProvider.dart';
import 'package:fixthis/providers/locationProvider.dart';
import 'package:fixthis/providers/productProvider.dart';
import 'package:fixthis/providers/userProvider.dart';
import 'package:fixthis/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userid;
  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    userid = user.id;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    userid = user.id;
    final _categories = Provider.of<CategoryListProvider>(context).categorylist;
    final _products = Provider.of<ProductListProvider>(context).Productlist;
    final _location = Provider.of<LocationProvider>(context).loaction;

    AuthService authService = AuthService();
    void _logout() {
      authService.SignOut(context);
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            // Location AppBar
            locationAppBar(
              location: _location,
            ),
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
                      // color: Colors.red,
                      child: Center(
                        child: Image.asset(
                          'assets/images/front.jpg',
                          width: 262,
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.blue,
                      child: Center(
                        child: Image.asset(
                          'assets/images/front2.png',
                          width: 262,
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.green,
                      child: Center(
                        child: Image.asset(
                          'assets/images/front1.jpg',
                          width: 262,
                        ),
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                  CategorytName:
                                      _categories.categorylist[i].name,
                                  product: _products.Productlist[j],
                                ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
