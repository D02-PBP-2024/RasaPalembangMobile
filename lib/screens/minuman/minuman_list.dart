import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/rp_card.dart';

class MinumanListPage extends StatelessWidget {
  final List<Map<String, dynamic>> minumanList = [
    {
      'gambarUrl': 'http://muhammad-fazil31-rasapalembang.pbp.cs.ui.ac.id/media/gambar_minuman/9fdf8667-faf3-4413-b01d-219ac847cf07.jpg',
      'namaMinuman': 'Boba ini namanya sangat panjang kurang panjang ternyata masih kurang panjang',
      'harga': 35000,
      'restoranName': 'Sushi Tei Palembang',
      'restoranUrl': '/restoran/123',
      'detailUrl': '/minuman/456',
    },
    {
      'gambarUrl': 'http://muhammad-fazil31-rasapalembang.pbp.cs.ui.ac.id/media/gambar_minuman/5bbfa325-0ce2-4bfa-b2d7-26ca59d40fce.jpg',
      'namaMinuman': 'Chicken Honey Mustard Salad',
      'harga': 15000,
      'restoranName': 'Sentral Kampung Pempek Palembang',
      'restoranUrl': '/restoran/124',
      'detailUrl': '/minuman/457',
    },
    {
      'gambarUrl': 'http://muhammad-fazil31-rasapalembang.pbp.cs.ui.ac.id/media/gambar_minuman/f625a53d-d917-43ec-aeb2-77885d9e578e.jpg',
      'namaMinuman': 'Es Taro',
      'harga': 22000,
      'restoranName': 'RM Sri Melayu',
      'restoranUrl': '/restoran/125',
      'detailUrl': '/minuman/458',
    },
  ];

  MinumanListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.60,
          ),
          itemCount: minumanList.length,
          itemBuilder: (context, index) {
            final minuman = minumanList[index];

            return RPCard(
              imageUrl: minuman['gambarUrl'],
              name: minuman['namaMinuman'],
              price: minuman['harga'],
              restoranName: minuman['restoranName'],
              restoranUrl: minuman['restoranUrl'],
              detailUrl: minuman['detailUrl'],
            );
          },
        ),
      ),
    );
  }
}
