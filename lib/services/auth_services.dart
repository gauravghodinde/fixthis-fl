import 'dart:convert';
import 'package:fixthis/main.dart';
import 'package:fixthis/model/user.dart';
import 'package:fixthis/pages/homepage.dart';
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

    try {
      // User user = User(
      //   id: '',
      //   name: name,
      //   email: email,
      //   phoneNumber: phoneNumber,
      //   city: city,
      //   password: password,
      // );
      // print(user.toJson().toString());
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/users/signup'),
        // body: user.toJson(),
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

    try {
      final navigator = Navigator.of(context);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      // final User user = User(
      //   id: '',
      //   name: '',
      //   email: '',
      //   phoneNumber: '',
      //   city: '',
      //   password: '',
      // );
      // User user = User(
      //   id: '',
      //   name: name,
      //   email: email,
      //   phoneNumber: phoneNumber,
      //   city: city,
      //   password: password,
      // );
      // print(user.toJson().toString());
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/users/login'),
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
}
