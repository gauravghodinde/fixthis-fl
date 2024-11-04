import 'dart:convert';
import 'package:fixthis/model/pendingActionList.dart';
import 'package:fixthis/model/user.dart';
import 'package:fixthis/pages/LoginSignupPage.dart';
import 'package:fixthis/pages/homepage.dart';
import 'package:fixthis/pages/loginpage.dart';
import 'package:fixthis/providers/RepairReqestProvider.dart';
import 'package:fixthis/providers/categoryProvider.dart';
import 'package:fixthis/providers/locationListProvider.dart';
import 'package:fixthis/providers/pendingActionProvider.dart';
import 'package:fixthis/providers/productProvider.dart';
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
    final navigator = Navigator.of(context);
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
        Uri.parse('${Constants.uri}users/signup'),
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
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false,
          );
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
        Uri.parse('${Constants.uri}users/login'),
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
          final responseBody = jsonDecode(res.body);
          final userBody = responseBody['body'];
          userProvider.setUser(jsonEncode(jsonDecode(res.body)['body']));
          await prefs.setString(
            'user',
            jsonEncode(jsonDecode(res.body)['body']),
          );
          String? fcmtoken = await prefs.getString("fcmtoken");
          String userid = userBody['_id'];
          if (fcmtoken != null && fcmtoken.isNotEmpty) {
            updateFcmToken(userid: userid, fcmtoken: fcmtoken);
          }
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

  void updateUser(
      {required BuildContext context,
      required String userid,
      String? name,
      String? city,
      String? fcmtoken}) async {
    if (userid.isEmpty) {
      showSnackBar(context, 'userid is required.');
      return;
    }

    try {
      final navigator = Navigator.of(context);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      print("logging in");

      Map<String, String> requestBody = {
        'userid': userid,
      };

      if (name != null) requestBody['name'] = name;
      if (city != null) requestBody['city'] = city;
      if (fcmtoken != null) requestBody['fcmtoken'] = fcmtoken;
      http.Response res = await http.post(
          Uri.parse('${Constants.uri}users/update'),
          // body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(requestBody));
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

          showSnackBar(
            context,
            'Fields updated successfully',
          );
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, " error ?? ${e.toString()}");
    }
  }

  void updateFcmToken(
      {required String userid, required String fcmtoken}) async {
    if (userid.isEmpty || fcmtoken.isEmpty) {
      print('userid || fcmtoken is required.');
      return;
    }

    try {
      print("updating fcm token");

      Map<String, String> requestBody = {
        'userid': userid,
        'fcmtoken': fcmtoken,
      };

      http.Response res = await http.post(
          Uri.parse('${Constants.uri}users/update'),
          // body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(requestBody));
      print('Response status: ${res.statusCode}');
      print('Response status: ${res}');
      print('Response body: ${res.body}');
      print('Response real body: ${jsonDecode(res.body)['body']}');

      if (res.statusCode < 300) {
        print("fcm updated successfully");
      } else {
        print("error : ${res.body}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = await prefs.getString("user");
    print("user ");
    print(user);
    if (user == null || user == "") {
      await prefs.setString('user', '');
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
    await prefs.setString('user', '');
    User usernew = User(
        id: "", name: "", email: "", phoneNumber: "", city: "", password: "");

    userProvider.setUserFromModel(usernew);
    navigator.push(
      MaterialPageRoute(builder: (context) => LoginSignUpPage()),
    );
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
        Uri.parse('${Constants.uri}location/get'),
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

  void fetchCategories({
    required BuildContext context,
  }) async {
    print("ffetch");
    var categoryListProvider =
        Provider.of<CategoryListProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('${Constants.uri}category/getall'),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      print('Response array: ${jsonEncode(jsonDecode(res.body)['body'])}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          categoryListProvider.setCategoryList(res.body);
        },
      );
    } catch (e) {
      print(e.toString());
    }
    print("ffetch");
  }

  Future<void> fetchRepairRequest({
    required BuildContext context,
    required String userid,
  }) async {
    print("fetching Reapir Requests");
    var repairRequestProvider =
        Provider.of<RepairRequestListProvider>(context, listen: false);
    print(userid);
    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}repair_request/get/user'),
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
          print("done ....................");
        },
      );
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void _fetchCategories({
    required BuildContext context,
  }) async {
    print("ffetch");
    var categoryListProvider =
        Provider.of<CategoryListProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('${Constants.uri}category/getall'),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      print('Response array: ${jsonEncode(jsonDecode(res.body)['body'])}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          categoryListProvider.setCategoryList(res.body);
        },
      );
    } catch (e) {
      print(e.toString());
    }
    print("ffetch");
  }

  void fetchProducts({
    required BuildContext context,
  }) async {
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
          productListProvider.setProductList(res.body);
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, " error ?? ${e.toString()}");
    }
  }

  void getRepairRequestsPendingAction({
    required BuildContext context,
    required String repairRequestId,
  }) async {
    print("thsi");
    print(repairRequestId);
    print("thsi");

    var pendingActionListProvider =
        Provider.of<PendingActionListProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}pending_action/get'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'repairRequestId': repairRequestId,
        }),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      print('Response array: ${jsonEncode(jsonDecode(res.body)['body'])}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          pendingActionListProvider.setPendingActionList(res.body);
          // set(res.body);
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, " error ?? ${e.toString()}");
    }
  }

  void updatePendingAction({
    required BuildContext context,
    required String PendingActionId,
    required String response,
    required String comment,
  }) async {
    print("updating pending action");
    var pendingActionListProvider =
        Provider.of<PendingActionListProvider>(context, listen: false);
    // print(userid);
    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}pending_action/update'),
        // body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'PendingActionId': PendingActionId,
          'response': response,
          'comment': comment,
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
          pendingActionListProvider.setPendingActionList(res.body);
        },
      );
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
