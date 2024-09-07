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
  AuthService authService = AuthService();
  bool _stretch = true;
  bool _isLoading = true;
  late String userid;
  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    userid = user.id;

    authService.fetchCategories(context: context);
    authService.fetchRepairRequest(context: context, userid: userid);
    authService.fetchProducts(context: context);
    authService.fetchLocations(context: context, userid: userid);
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

    AuthService authService = AuthService();

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
          items: const [
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
