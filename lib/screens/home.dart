import 'package:flutter/material.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/screens/forum/forum_list.dart';
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
    return Scaffold(
      body: ForumListPage(idRestoran: "f000d91a-908f-46b6-8dc0-c5e7a370aae1") // coba random id resto from fixture
    );
  }
}
