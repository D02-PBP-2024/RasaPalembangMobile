import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/pbp_django_auth.dart';
import 'package:rasapalembang/widget/rp_bottom_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest();
          return request;
        },
        child: MaterialApp(
          title: 'Rasa Palembang',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: RPColors.biruMuda),
            useMaterial3: true,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: RPColors.textFieldBackground,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: RPColors.biruMuda, width: 1.0),
              ),
              errorStyle: const TextStyle(
                color: RPColors.merahMuda,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: RPColors.merahMuda, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: RPColors.merahMuda, width: 1.0),
              ),
            ),
          ),
          home: const RPBottomNavbar(),
        ));
  }
}
