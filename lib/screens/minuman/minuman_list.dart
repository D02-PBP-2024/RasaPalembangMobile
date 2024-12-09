import 'package:flutter/material.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/screens/minuman/minuman_detail.dart';
import 'package:rasapalembang/widget/rp_menu_card.dart';

class MinumanListPage extends StatelessWidget {
  final List<Map<String, dynamic>> minumanList = [
    {
      "pk": "052e46d2-d529-4f15-a912-6e57dfdf758c",
      "fields": {
        "nama": "Boba Ceritanya tulisan ini sangat panjang ya, apa yang tejadi?",
        "harga": 35000,
        "deskripsi": "Boba yang kenyal dan lezat, disajikan dalam minuman segar dengan berbagai pilihan rasa, seperti teh, susu, atau buah. Menawarkan pengalaman tekstur yang unik dan menyenangkan di setiap tegukan. Cocok untuk dinikmati kapan saja, baik sebagai camilan atau minuman menyegarkan.",
        "gambar": "https://raw.githubusercontent.com/D02-PBP-2024/mediafiles/refs/heads/main/gambar_minuman/00c689af-ca68-49a5-9f24-6bf550c3a65f.jpg",
        "ukuran": "BESAR",
        "tingkat_kemanisan": 100,
        "restoran": "130561a8-c4d5-4b8e-ba5c-a36deeafd14d"
      }
    },
    {
      "pk": "052e46d2-d529-4f15-a912-6e57dfdf758c",
      "fields": {
        "nama": "Lemon",
        "harga": 35000,
        "deskripsi": "Boba yang kenyal dan lezat, disajikan dalam minuman segar dengan berbagai pilihan rasa, seperti teh, susu, atau buah. Menawarkan pengalaman tekstur yang unik dan menyenangkan di setiap tegukan. Cocok untuk dinikmati kapan saja, baik sebagai camilan atau minuman menyegarkan.",
        "gambar": "https://raw.githubusercontent.com/D02-PBP-2024/mediafiles/refs/heads/main/gambar_minuman/00c689af-ca68-49a5-9f24-6bf550c3a65f.jpg",
        "ukuran": "BESAR",
        "tingkat_kemanisan": 100,
        "restoran": "130561a8-c4d5-4b8e-ba5c-a36deeafd14d"
      }
    }
  ];

  MinumanListPage({super.key});

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
          itemCount: minumanList.length,
          itemBuilder: (context, index) {
            final minuman = Minuman.fromJson(minumanList[index]);

            return RPMenuCard(
              gambar: minuman.fields.gambar,
              nama: minuman.fields.nama,
              harga: minuman.fields.harga,
              restoran: minuman.fields.restoran,
              menuDetailPage: MinumanDetailPage(minuman: minuman),
            );
          },
        ),
      ),
    );
  }
}
