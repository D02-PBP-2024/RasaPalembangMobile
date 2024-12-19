import 'package:flutter/material.dart';
import 'package:rasapalembang/screens/forum/forum_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ForumListPage(
            idRestoran:
                "f000d91a-908f-46b6-8dc0-c5e7a370aae1") // coba random id resto from fixture
        );
  }
}
