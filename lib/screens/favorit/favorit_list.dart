import 'package:flutter/material.dart';
import 'package:rasapalembang/models/favorit.dart';
import 'package:rasapalembang/screens/favorit/favorit_detail.dart';
import 'package:rasapalembang/widget/rp_favorit_card.dart';

class FavoritListPage extends StatelessWidget {
  final List<Favorit> favoritList;

  const FavoritListPage({
    super.key,
    required this.favoritList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Favorit'),
      ),
      body: favoritList.isNotEmpty
          ? ListView.builder(
              itemCount: favoritList.length,
              itemBuilder: (context, index) {
                return RPFavoritCard(
                  favorit: favoritList[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritDetailPage(
                          favorit: favoritList[index],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: Text('Belum ada favorit yang ditambahkan.'),
            ),
    );
  }
}
