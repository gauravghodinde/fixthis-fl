import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final notificationSettings =
      await FirebaseMessaging.instance.requestPermission(provisional: true);

  print("start main");
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // print(notificationSettings.authorizationStatus.name);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    await prefs.setString('fcmtoken', token);
  }
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
    print("start \n\n\n");
    print(fcmToken);

    await prefs.setString('fcmtoken', fcmToken);

    AuthService authService = AuthService();

    String? user = await prefs.getString("user");
    if (user != null) {
      final decodedUser = jsonDecode(user);
      String userId = decodedUser['_id'];
      authService.updateFcmToken(userid: userId, fcmtoken: fcmToken);
    }
    print("end \n\n\n");

    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  }).onError((err) {
    // Error getting token.
  });
  // final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//   final notificationSettings =
//       await FirebaseMessaging.instance.requestPermission(provisional: true);

// // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
//   final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//   if (apnsToken != null) {
//     // APNS token is available, make FCM plugin API requests...
//   }
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
