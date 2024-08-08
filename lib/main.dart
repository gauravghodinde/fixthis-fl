import 'package:fixthis/pages/homepage.dart';
import 'package:fixthis/pages/loginpage.dart';
import 'package:fixthis/pages/signuppage.dart';
import 'package:fixthis/providers/categoryProvider.dart';
import 'package:fixthis/providers/locationListProvider.dart';
import 'package:fixthis/providers/locationProvider.dart';
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
  // This widget is the root of your application.

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
      // home: Provider.of<UserProvider>(context).user.id != ""
      //     ? HomePage()
      //     : MyHomePage(),
      home: HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00BF63),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 98, 0, 0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 262,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(180, 18, 0, 0),
              child: Image.asset(
                'assets/images/lamp.png',
                width: 88,
                height: 97,
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.heirght,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 32, 32, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/toster.png',
                                width: 40,
                                height: 55,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/watch.png',
                                width: 40,
                                height: 55,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/iron.png',
                                width: 40,
                                height: 55,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/headphone.png',
                                width: 40,
                                height: 55,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/screw.png',
                                width: 40,
                                height: 55,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32.0, 16, 32, 8),
                        child: Text(
                          " one-stop solution for fast repairs! We collect any item, repair it with expert precision, and return it to you within a day. Experience hassle-free service and get your belongings back in perfect working condition quickly and efficiently",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width / 5,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black,
                              ),
                              elevation: MaterialStateProperty.all<double>(5),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.white24),
                              shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.25),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width / 5,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              elevation: MaterialStateProperty.all<double>(5),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.black26),
                              shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Text(
                              "SiGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.25),
                            ),
                          ),
                        ),
                      ),
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
