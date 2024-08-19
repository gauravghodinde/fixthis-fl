import 'dart:convert';
import 'package:fixthis/main.dart';
import 'package:fixthis/model/user.dart';
import 'package:fixthis/pages/homepage.dart';
import 'package:fixthis/providers/locationListProvider.dart';
import 'package:fixthis/providers/userProvider.dart';
import 'package:fixthis/utils/constants.dart';
import 'package:fixthis/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String city,
    required String password,
    required String phoneNumber,
  }) async {
    if (name.isEmpty ||
        email.isEmpty ||
        city.isEmpty ||
        phoneNumber.isEmpty ||
        password.isEmpty) {
      showSnackBar(context, 'All fields are required.');
      return;
    }
    print("int signin");

    try {
      http.Response res = await http.post(
        Uri.parse(
            'https://ft-final-gauravs-projects-9d6ba5c9.vercel.app/users/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'phoneNumber': phoneNumber,
          'email': email,
          'city': city,
          'password': password,
        }),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials',
          );
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, " error ?? ${e.toString()}");
    }
  }

  void logInUser({
    required BuildContext context,
    required String password,
    required String phoneNumber,
  }) async {
    if (phoneNumber.isEmpty || password.isEmpty) {
      showSnackBar(context, 'All fields are required.');
      return;
    }
    print(phoneNumber);
    print(password);

    try {
      final navigator = Navigator.of(context);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      print("logging in");
      http.Response res = await http.post(
        Uri.parse(
            'https://ft-final-gauravs-projects-9d6ba5c9.vercel.app/users/login'),
        // body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': phoneNumber,
          'password': password,
        }),
      );
      print('Response status: ${res.statusCode}');
      print('Response status: ${res}');
      print('Response body: ${res.body}');
      print('Response real body: ${jsonDecode(res.body)['body']}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(jsonEncode(jsonDecode(res.body)['body']));
          await prefs.setString(
            'user',
            jsonEncode(jsonDecode(res.body)['body']),
          );
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
          // showSnackBar(
          //   context,
          //   'Logged in Successfully!',
          // );
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, " error ?? ${e.toString()}");
    }
  }

  void getUserData(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("user");
    print("user ");
    print(user);
    await prefs.setString('user', '');
    if (user == null || user == "") {
      print("setting to null");
      User user = User(
          id: "", name: "", email: "", phoneNumber: "", city: "", password: "");
      userProvider.setUserFromModel(user);
    } else {
      userProvider.setUser(user);
    }
  }

  void SignOut(BuildContext context) async {
    final navigator = Navigator.of(context);

    var userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("user");
    print(user);
    User usernew = User(
        id: "", name: "", email: "", phoneNumber: "", city: "", password: "");

    userProvider.setUserFromModel(usernew);
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyHomePage()),
        (route) => false);
  }

  void fetchLocations({
    required BuildContext context,
    required String userid,
  }) async {
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
        },
      );
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
