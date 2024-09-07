import 'package:fixthis/pages/LoginSignupPage.dart';
import 'package:fixthis/pages/homepage.dart';
import 'package:fixthis/providers/DeliveryLocationProvider.dart';
import 'package:fixthis/providers/RepairReqestProvider.dart';
import 'package:fixthis/providers/categoryProvider.dart';
import 'package:fixthis/providers/locationListProvider.dart';
import 'package:fixthis/providers/locationProvider.dart';
import 'package:fixthis/providers/pendingActionProvider.dart';
import 'package:fixthis/providers/productProvider.dart';
import 'package:fixthis/providers/userProvider.dart';
import 'package:fixthis/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => CategoryListProvider()),
      ChangeNotifierProvider(create: (_) => ProductListProvider()),
      ChangeNotifierProvider(create: (_) => LocationListProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => DeliveryLocationProvider()),
      ChangeNotifierProvider(create: (_) => RepairRequestListProvider()),
      ChangeNotifierProvider(create: (_) => PendingActionListProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    print("logginng in");
    authService.getUserData(context);
    print("logged  ");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixThis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff00bf63)),
        useMaterial3: true,
      ),
      home: Provider.of<UserProvider>(context).user.id != ""
          ? HomePage()
          : LoginSignUpPage(),
    );
  }
}
