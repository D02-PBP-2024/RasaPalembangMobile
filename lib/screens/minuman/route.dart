import 'package:flutter/material.dart';
import 'package:rasapalembang/screens/minuman/minuman_list.dart';
import 'package:rasapalembang/screens/minuman/minuman_tambah.dart';

class MinumanRoute extends StatelessWidget {
  const MinumanRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MinumanTambahPage(),
    );
  }
}
