import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/screens/authentication/login.dart';
import 'package:rasapalembang/screens/authentication/profile.dart';
import 'package:rasapalembang/services/user_service.dart';

class AkunRoute extends StatelessWidget {
  const AkunRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    if (request.loggedIn && request.user != null) {
      return ProfilePage(
        username: request.user!.username,
        nama: request.user!.nama,
        deskripsi: request.user!.deskripsi,
        peran: request.user!.peran,
        foto: request.user!.foto,
        poin: request.user!.poin,
        dateJoined: request.user!.dateJoined,
        loggedInUsername: request.user!.username,
      );
    } else {
      return const LoginPage();
    }
  }
}
