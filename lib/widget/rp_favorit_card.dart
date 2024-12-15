import 'package:flutter/material.dart';
import 'package:rasapalembang/models/favorit.dart';

class RPFavoritCard extends StatelessWidget {
  final Favorit favorit;
  final VoidCallback onTap;

  const RPFavoritCard({
    super.key,
    required this.favorit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                favorit.fields.restoran,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Makanan: ${favorit.fields.makanan}'),
              Text('Minuman: ${favorit.fields.minuman}'),
              const SizedBox(height: 8),
              Text('Catatan: ${favorit.fields.catatan}'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "User ID: ${favorit.fields.user}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    "Favorit",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
