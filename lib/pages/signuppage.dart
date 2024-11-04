import 'package:fixthis/services/auth_services.dart';
import 'package:fixthis/utils/constants.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void _signUp() {
    print("pesse");
    authService.signUpUser(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      city: _cityController.text,
      password: _passwordController.text,
      phoneNumber: _phoneController.text,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Future<void> _signup() async {
  //   if (_formKey.currentState!.validate()) {
  //     final name = _nameController.text;
  //     final phone = _phoneController.text;
  //     final email = _emailController.text;
  //     final city = _cityController.text;
  //     final password = _passwordController.text;

  //     final url = Uri.parse(
  //         'https://ft-final-hslfllsqe-gauravs-projects-9d6ba5c9.vercel.app/users/signup');
  //     final response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  // body: jsonEncode(<String, String>{
  //   'name': name,
  //   'phoneNumber': phone,
  //   'email': email,
  //   'city': city,
  //   'password': password,
  // }),
  //     );
  //     print(response.body);
  //     print(response.statusCode);
  //     if (response.statusCode < 300) {
  //       // Handle successful signup
  //       final data = response.body;
  //       print('Signup successful: $data');
  //     } else {
  //       // Handle signup error

  //       print('Signup failed: ${response.reasonPhrase}');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: Color(0xff00BF63),
      backgroundColor: Colors.white,
      body: SafeArea(
        // top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 8,
                decoration: BoxDecoration(
                  color: Color(Constants.mainColorHsh),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/signup.png',
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8, 32, 8.0),
                        child: SizedBox(
                          height: 48,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32.0, 8, 32, 8),
                        child: Text(
                          " Signup to FixThis Repairs!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 4,
                                height: 68,
                                child: TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Name',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 4,
                                height: 68,
                                child: TextFormField(
                                  controller: _phoneController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Phone Number',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                      return 'Please enter a valid phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 4,
                                height: 68,
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Email',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 4,
                                height: 68,
                                child: TextFormField(
                                  controller: _cityController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'City',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your city';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 4,
                                height: 68,
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Password',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 8) {
                                      return 'Password must be at least 8 characters long';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 5,
                                child: ElevatedButton(
                                  onPressed: _signUp,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.black,
                                    ),
                                    elevation:
                                        MaterialStateProperty.all<double>(5),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white24),
                                    shadowColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                  child: Text(
                                    "SIGN UP",
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
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    elevation:
                                        MaterialStateProperty.all<double>(5),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black26),
                                    shadowColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                  child: Text(
                                    "Already have an account",
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
