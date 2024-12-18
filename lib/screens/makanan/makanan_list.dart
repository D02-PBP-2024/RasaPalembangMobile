import 'package:flutter/material.dart';
import 'package:rasapalembang/screens/makanan/makanan_detail.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/widget/rp_menu_card.dart';

class MakananListPage extends StatelessWidget {
  MakananListPage({super.key});

  @override
  Widget build(BuildContext context) {
    MakananService makanan = MakananService();
    return Scaffold(
      body: FutureBuilder(
        future: makanan.get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Text('loading');
          } else {
            if (!snapshot.hasData) {
              return const Text('belum ada makanan');
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.60,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final makanan = snapshot.data[index];

                    return RPMenuCard(
                      gambar: makanan.fields.gambar,
                      nama: makanan.fields.nama,
                      harga: makanan.fields.harga,
                      restoran: makanan.fields.restoran.fields.nama,
                      menuDetailPage: MakananDetailPage(makanan: makanan),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
