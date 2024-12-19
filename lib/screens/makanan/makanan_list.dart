import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/screens/makanan/makanan_detail.dart';
import 'package:rasapalembang/widget/rp_menu_card.dart';

class MakananListPage extends StatelessWidget {
  final List<Map<String, dynamic>> makananList = [
    {
      "pk": "d0e880e2-1a14-472a-9f51-4ef158091383",
      "fields": {
        "nama": "Pempek Kapal Selam",
        "harga": 20000,
        "deskripsi": "Pempek dengan isian telur di dalamnya, disajikan dengan kuah cuka yang segar.",
        "gambar": "/media/gambar_makanan/71b61210-b7e9-4334-b966-4a035a199a76.jpg",
        "kalori": 80,
        "restoran": {
          "pk": "0cc904b9-6003-48f1-a237-6b9a709ed6ae",
          "fields": {
            "nama": "Sentral Kampung Pempek Palembang",
            "alamat": "Jl. Beringin Janggut, Talang Semut, Kec. Bukit Kecil, Kota Palembang, Sumatera Selatan 30135",
            "jam_buka": "07:30",
            "jam_tutup": "22:00",
            "nomor_telepon": "(0711) 353934",
            "gambar": "/media/gambar_restoran/77ad1190-756f-4516-bb56-6d9443b62819.jpg",
            "user": "ahmadjaya"
          }
        },
        "kategori": [
          "375b10ea-f735-4554-947f-a2dc7af9eb50"
        ]
      }
    },
    {
      "pk": "d758afc4-0162-4e1b-9490-cad603b5cf2a",
      "fields": {
        "nama": "Pempek Lenjer",
        "harga": 15000,
        "deskripsi": "Pempek panjang yang kenyal, cocok disajikan dengan cuka pempek.",
        "gambar": "/media/gambar_makanan/f4709b47-b2e2-431e-b18b-d67b90a4663f.jpg",
        "kalori": 90,
        "restoran": {
          "pk": "0cc904b9-6003-48f1-a237-6b9a709ed6ae",
          "fields": {
            "nama": "Sentral Kampung Pempek Palembang",
            "alamat": "Jl. Beringin Janggut, Talang Semut, Kec. Bukit Kecil, Kota Palembang, Sumatera Selatan 30135",
            "jam_buka": "07:30",
            "jam_tutup": "22:00",
            "nomor_telepon": "(0711) 353934",
            "gambar": "/media/gambar_restoran/77ad1190-756f-4516-bb56-6d9443b62819.jpg",
            "user": "ahmadjaya"
          }
        },
        "kategori": [
          "375b10ea-f735-4554-947f-a2dc7af9eb50"
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
              gambar: makanan.gambar,
              nama: makanan.nama,
              harga: makanan.harga,
              restoran: makanan.restoran.nama,
              menuDetailPage: MakananDetailPage(makanan: makanan),
            );
          },
        ),
      ),
    );
  }
}
