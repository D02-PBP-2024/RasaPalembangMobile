import 'package:flutter/material.dart';
import 'package:rasapalembang/screens/forum/forum_list.dart';

class RestoranRoute extends StatelessWidget {
  const RestoranRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForumListPage(),
    );
  }
}
