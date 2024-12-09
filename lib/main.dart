import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/utils/pbp_django_auth.dart';
import 'package:rasapalembang/widget/rp_bottom_navbar.dart';
import 'package:rasapalembang/widget/rp_theme.dart';

void main() async {
  await initializeDateFormatting('id_ID', null);
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
        theme: RPTheme.theme,
        home: const RPBottomNavbar(),
      )
    );
  }
}
