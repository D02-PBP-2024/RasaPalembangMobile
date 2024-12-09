import 'package:flutter/material.dart';
import 'package:rasapalembang/screens/makanan/makanan_list.dart';

class MakananRoute extends StatelessWidget {
  const MakananRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MakananListPage(),
    );
  }
}
