import 'package:fixthis/providers/userProvider.dart';
import 'package:fixthis/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    AuthService authService = AuthService();
    void _logout() {
      authService.SignOut(context);
    }

    return Scaffold(
      body: Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("HI ${user.phoneNumber}"),
              ElevatedButton(onPressed: _logout, child: Text("Log Out"))
            ],
          ),
        ),
      ),
    );
  }
}
