import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/providers/tab_provider.dart';
import 'package:rasapalembang/widget/rp_register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = Provider.of<TabProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RPRegister(
          redirect: () {
            Navigator.pop(context);
            selectedTab.tab = 0;
          },
          loginPage: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
