import 'package:flutter/material.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/screens/restoran/restoran_detail.dart';
import 'package:rasapalembang/screens/restoran/restoran_form.dart';
import 'package:rasapalembang/widget/rp_menu_card.dart';

class RestoranListPage extends StatefulWidget {
  const RestoranListPage({super.key});

  @override
  State<RestoranListPage> createState() => _RestoranListPageState();
}

class _RestoranListPageState extends State<RestoranListPage> {
  final List<Map<String, dynamic>> restoranList = [];

  void _addNewRestoran(Map<String, dynamic> newRestoran) {
    setState(() {
      restoranList.add(newRestoran);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Restoran'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                final newRestoran = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestoranFormPage(),
                  ),
                );

                if (newRestoran != null) {
                  _addNewRestoran(newRestoran);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF54BAB9), // Warna tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Tambah Restoran'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 kartu per baris
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7, // Menyesuaikan rasio kartu
          ),
          itemCount: restoranList.length,
          itemBuilder: (context, index) {
            final restoran = Restoran.fromJson(restoranList[index]);

            return RPMenuCard(
              gambar: restoran.fields.gambar,
              nama: restoran.fields.nama,
              harga: 0, // Harga tidak ada di restoran
              restoran: restoran.pk,
              menuDetailPage: RestoranDetailPage(restoran: restoran),
            );
          },
        ),
      ),
    );
  }
}
