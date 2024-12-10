import 'package:flutter/material.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/screens/minuman/minuman_detail.dart';
import 'package:rasapalembang/widget/rp_menu_card.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              RPTextFormField(
                hintText: 'Cari',
                prefixIcon: Icons.search,
              ),
            ],
          )
        ),
      )
    );
  }
}
