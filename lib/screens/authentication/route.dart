import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/screens/authentication/login.dart';
import 'package:rasapalembang/screens/authentication/profile.dart';
import 'package:rasapalembang/screens/authentication/register.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class AkunRoute extends StatelessWidget {
  const AkunRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    return Scaffold(
      body: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          if (request.loggedIn && request.user != null) {
            return MaterialPageRoute(builder: (context) => ProfilePage(
              username: request.user!.username,
              nama: request.user!.nama,
              deskripsi: request.user!.deskripsi,
              peran: request.user!.peran,
              foto: request.user!.foto == "" ?
              RPUrls.noProfileUrl :
              RPUrls.baseUrl + request.user!.foto,
              poin: request.user!.poin,
              dateJoined: request.user!.dateJoined,
              loggedInUsername: request.user!.username,
            ));
          } else if (settings.name == '/register') {
            return MaterialPageRoute(builder: (context) => const RegisterPage());
          } else {
            return MaterialPageRoute(builder: (context) => const LoginPage());
          }
        },
      ),
    );
  }
}
