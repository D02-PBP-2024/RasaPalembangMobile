import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/providers/tab_provider.dart';
import 'package:rasapalembang/screens/authentication/register.dart';
import 'package:rasapalembang/widget/rp_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = Provider.of<TabProvider>(context);
    return Scaffold(
      body: Center(
        child: RPLogin(
          redirect: () {
            selectedTab.tab = 0;
          },
          registerPage: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
