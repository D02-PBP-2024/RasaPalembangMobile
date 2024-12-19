import 'package:flutter/material.dart';
import 'package:rasapalembang/screens/minuman/minuman_detail.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/widget/rp_menu_card.dart';

class MinumanListPage extends StatelessWidget {
  const MinumanListPage({super.key});

  @override
  Widget build(BuildContext context) {
    MinumanService minuman = MinumanService();
    return Scaffold(
      body: FutureBuilder(
        future: minuman.get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Text('loading');
          } else {
            if (!snapshot.hasData) {
              return const Text('belum ada minuman');
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.60,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final minuman = snapshot.data[index];

                    return RPMenuCard(
                      gambar: minuman.gambar,
                      nama: minuman.nama,
                      harga: minuman.harga,
                      restoran: minuman.restoran.nama,
                      menuDetailPage: MinumanDetailPage(minuman: minuman),
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
