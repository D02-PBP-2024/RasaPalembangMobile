import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/screens/makanan/makanan_detail.dart';
import 'package:rasapalembang/widget/rp_menu_card.dart';

class MakananListPage extends StatelessWidget {
  final List<Map<String, dynamic>> makananList = [
    {
      "pk": "d758afc4-0162-4e1b-9490-cad603b5cf2a",
      "fields": {
          "nama": "Pempek Lenjer",
          "harga": 15000,
          "deskripsi": "Pempek panjang yang kenyal, cocok disajikan dengan cuka pempek.",
          "gambar": "gambar_makanan/f4709b47-b2e2-431e-b18b-d67b90a4663f.jpg",
          "kalori": 90,
          "restoran": "0cc904b9-6003-48f1-a237-6b9a709ed6ae",
          "kategori": [
              "375b10ea-f735-4554-947f-a2dc7af9eb50"
          ]
      }
    },
    {
      "pk": "52aad79b-167a-487b-8056-940cc3d0c0c2",
      "fields": {
          "nama": "Tsukune Nokke Sushi",
          "harga": 68000,
          "deskripsi": "Tsukune Nokke Sushi adalah hidangan sushi yang unik, menggabungkan bola daging ayam (tsukune) yang dibumbui dengan nasi sushi. Disajikan dengan saus tare yang manis dan hiasan wijen atau bawang hijau, hidangan ini menawarkan perpaduan rasa gurih dan tekstur yang kenyal, cocok sebagai camilan atau hidangan utama.",
          "gambar": "gambar_makanan/691d850c-dd91-4ee9-b7b0-0f921c9ba780.jpg",
          "kalori": 80,
          "restoran": "130561a8-c4d5-4b8e-ba5c-a36deeafd14d",
          "kategori": [
              "0de708ca-38bc-442c-9fba-4f1532487eb4"
          ]
      }
    },
  ];

  MakananListPage({super.key});

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
          itemCount: makananList.length,
          itemBuilder: (context, index) {
            final makanan = Makanan.fromJson(makananList[index]);

            return RPMenuCard(
              gambar: makanan.fields.gambar,
              nama: makanan.fields.nama,
              harga: makanan.fields.harga,
              restoran: makanan.fields.restoran,
              menuDetailPage: MakananDetailPage(makanan: makanan),
            );
          },
        ),
      ),
    );
  }
}
