import 'package:flutter/material.dart';
import 'package:rasapalembang/models/favorit.dart';

class FavoritDetailPage extends StatelessWidget {
  final Favorit favorit;

  const FavoritDetailPage({
    super.key,
    required this.favorit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(favorit.fields.restoran),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              favorit.fields.restoran,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Makanan: ${favorit.fields.makanan}'),
            Text('Minuman: ${favorit.fields.minuman}'),
            const SizedBox(height: 8),
            Text('Catatan: ${favorit.fields.catatan}'),
            const SizedBox(height: 8),
            Text('User ID: ${favorit.fields.user}'),
          ],
        ),
      ),
    );
  }
}