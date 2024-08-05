import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixthis/providers/userProvider.dart';
import 'package:fixthis/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _stretch = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    AuthService authService = AuthService();

    void _logout() {
      authService.SignOut(context);
    }

    return Scaffold(
      backgroundColor: Colors.white60,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            // Location AppBar
            SliverAppBar(
              floating: false,
              snap: false,
              backgroundColor: Colors.white60,
              expandedHeight: kToolbarHeight,
              flexibleSpace: FlexibleSpaceBar(
                background: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.location_on),
                    ),
                    Expanded(
                      child: Text("location"),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'search',
                    ),
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
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      for (var i = 0; i < 10; i++)
                        Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          color: Colors.teal,
                          child: Center(
                            child: Text(
                              " a $i",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // List
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text(
                        '$index',
                      ),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
