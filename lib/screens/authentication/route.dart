import 'package:flutter/material.dart';
import 'package:rasapalembang/screens/authentication/login.dart';
import 'package:rasapalembang/screens/authentication/register.dart';

class AkunRoute extends StatelessWidget {
  const AkunRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == '/register') {
            return MaterialPageRoute(builder: (context) => const RegisterPage());
          } else {
            return MaterialPageRoute(builder: (context) => const LoginPage());
          }
        },
      ),
    );
  }
}
