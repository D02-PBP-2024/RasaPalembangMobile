import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/screens/authentication/login.dart';
import 'package:rasapalembang/screens/authentication/profile.dart';
import 'package:rasapalembang/screens/authentication/register.dart';
import 'package:rasapalembang/utils/pbp_django_auth.dart';

class AkunRoute extends StatelessWidget {
  const AkunRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    if (request.loggedIn) {
      return ProfilePage(
          username: 'dummy',
          nama: 'Nama Dummy',
          deskripsi: 'Deskripsi Dummy',
          peran: 'pengulas',
          foto: 'https://raw.githubusercontent.com/D02-PBP-2024/RasaPalembang/refs/heads/master/static/images/avatar.png',
          poin: 100,
          dateJoined: DateTime.parse('2024-10-25T15:41:36.294Z'),
      );
    } else {
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
}
