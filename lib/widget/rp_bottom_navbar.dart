import 'package:flutter/material.dart';
import 'package:rasapalembang/screens/home.dart';
import 'package:rasapalembang/screens/authentication/route.dart';
import 'package:rasapalembang/screens/makanan/route.dart';
import 'package:rasapalembang/screens/minuman/route.dart';
import 'package:rasapalembang/screens/restoran/route.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class RPBottomNavbar extends StatefulWidget {
  const RPBottomNavbar({super.key});

  @override
  _RPBottomNavbarState createState() => _RPBottomNavbarState();
}

class _RPBottomNavbarState extends State<RPBottomNavbar> {
  int _selectedTab = 0;

  final List _pages = [
    const HomePage(),
    const MakananRoute(),
    const MinumanRoute(),
    const RestoranRoute(),
    const AkunRoute(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: RPColors.biruMuda,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Makanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            label: 'Minuman',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restoran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
