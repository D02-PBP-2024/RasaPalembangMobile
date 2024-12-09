import 'package:flutter/material.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/screens/restoran/restoran_detail.dart';
import 'package:rasapalembang/widget/rp_menu_card.dart';

class RestoranListPage extends StatelessWidget {
  final List<Map<String, dynamic>> restoranList = [
    {
      "id": "052e46d2-d529-4f15-a912-6e57dfdf758c",
      "nama": "Restoran Ceritanya tulisan ini sangat panjang ya, apa yang terjadi?",
      "alamat": "Jl. Maju Bersama No. 10",
      "jam_buka": "08:00",
      "jam_tutup": "22:00",
      "nomor_telepon": "081234567890",
      "gambar":
          "https://raw.githubusercontent.com/D02-PBP-2024/mediafiles/refs/heads/main/gambar_restoran/00c689af-ca68-49a5-9f24-6bf550c3a65f.jpg",
      "user": "123"
    },
    {
      "id": "130561a8-c4d5-4b8e-ba5c-a36deeafd14d",
      "nama": "Restoran Lemon",
      "alamat": "Jl. Sehat No. 21",
      "jam_buka": "09:00",
      "jam_tutup": "23:00",
      "nomor_telepon": "081298765432",
      "gambar":
          "https://raw.githubusercontent.com/D02-PBP-2024/mediafiles/refs/heads/main/gambar_restoran/00c689af-ca68-49a5-9f24-6bf550c3a65f.jpg",
      "user": "456"
    }
  ];

  RestoranListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.60,
          ),
          itemCount: restoranList.length,
          itemBuilder: (context, index) {
            final restoran = Restoran.fromJson(restoranList[index]);

            return RPMenuCard(
              gambar: restoran.gambar ?? '',
              nama: restoran.nama,
              harga: 0, // Restoran tidak memiliki harga
              restoran: restoran.id,
              menuDetailPage: RestoranDetailPage(restoran: restoran),
            );
          },
        ),
      ),
    );
  }
}
