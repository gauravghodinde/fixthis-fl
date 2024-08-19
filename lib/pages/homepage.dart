import 'dart:convert';

import 'package:fixthis/pages/HomeScreen.dart';
import 'package:fixthis/pages/MyRequestScreen.dart';

import 'package:fixthis/providers/RepairReqestProvider.dart';
import 'package:fixthis/providers/categoryProvider.dart';
import 'package:fixthis/providers/locationListProvider.dart';
import 'package:fixthis/providers/locationProvider.dart';
import 'package:fixthis/providers/productProvider.dart';
import 'package:fixthis/providers/userProvider.dart';
import 'package:fixthis/services/auth_services.dart';
import 'package:fixthis/utils/constants.dart';
import 'package:fixthis/utils/utils.dart';
import 'package:flutter/material.dart';
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
  late String userid;
  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    userid = user.id;

    _fetchCategories();
    _fetchRepairRequest();
    _fetchProducts();
    _fetchLocations();
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
    print("ffetch");
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
      // showSnackBar(context, " error ?? ${e.toString()}");
    }
    print("ffetch");
  }

  Future<void> _fetchRepairRequest() async {
    print("fetching Reapir Requests");
    var repairRequestProvider =
        Provider.of<RepairRequestListProvider>(context, listen: false);
    print(userid);
    try {
      http.Response res = await http.post(
        Uri.parse('http://192.168.231.58:3000/repair_request/get/user'),
        // body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'userId': userid,
        }),
      );
      print(res.body);
      print("fetching Reapir Requests");

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(res.body);
          repairRequestProvider.setRepairRequestList(res.body);
          setState(() {
            // _categories =
            //     jsonResponse.map((data) => Category.fromJson(data)).toList();
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<void> _fetchLocations() async {
    print("fetching location");
    var locationListProvider =
        Provider.of<LocationListProvider>(context, listen: false);
    print(userid);
    try {
      http.Response res = await http.post(
        Uri.parse('http://192.168.231.58:3000/location/get'),
        // body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'userId': userid,
        }),
      );
      print(res.body);
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(res.body);
          locationListProvider.setLocationList(res.body);
          setState(() {
            // _categories =
            //     jsonResponse.map((data) => Category.fromJson(data)).toList();
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void _fetchProducts() async {
    var productListProvider =
        Provider.of<ProductListProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('${Constants.uri}product/getall'),
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
      // showSnackBar(context, " error ?? ${e.toString()}");
    }
  }

  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    MyRequestScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    userid = user.id;
    final _categories = Provider.of<CategoryListProvider>(context).categorylist;
    final _products = Provider.of<ProductListProvider>(context).Productlist;
    final _location = Provider.of<LocationProvider>(context).loaction;
    final int page = 0;
    // print(_categories);
    AuthService authService = AuthService();
    final List<String> items = List.generate(20, (index) => 'Item $index');
    void _logout() {
      authService.SignOut(context);
    }

    print(_currentIndex);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: _screens[_currentIndex]);
  }
}
