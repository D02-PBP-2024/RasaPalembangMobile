import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/providers/tab_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final selectedTab = Provider.of<TabProvider>(context);

    final List<Widget> _pages = [
      const HomePage(),
      const MakananRoute(),
      const MinumanRoute(),
      const RestoranRoute(),
      const AkunRoute(),
    ];

    return Scaffold(
      body: _pages[selectedTab.tab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab.tab,
        onTap: (index) => selectedTab.tab = index,
        selectedItemColor: RPColors.biruMuda,
        selectedFontSize: 12,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.rice_bowl),
            label: 'Makanan',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            label: 'Minuman',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Restoran',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
