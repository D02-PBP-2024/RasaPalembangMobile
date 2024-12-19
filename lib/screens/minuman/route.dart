import 'package:flutter/material.dart';
import 'package:rasapalembang/screens/minuman/minuman_list.dart';

class MinumanRoute extends StatelessWidget {
  const MinumanRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MinumanListPage(),
    );
  }
}
