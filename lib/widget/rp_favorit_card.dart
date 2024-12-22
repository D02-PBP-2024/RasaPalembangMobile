import 'package:flutter/material.dart';
import 'package:rasapalembang/models/favorit.dart';

class RPFavoritCard extends StatelessWidget {
  final Favorit favorit;
  final VoidCallback onTap;
  final VoidCallback delete;
  final VoidCallback edit;

  const RPFavoritCard({
    super.key,
    required this.favorit,
    required this.onTap,
    required this.delete,
    required this.edit,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    favorit.fields.restoran != null
                      ? favorit.fields.restoran!.nama
                      : favorit.fields.makanan != null
                        ? favorit.fields.makanan!.nama
                        : favorit.fields.minuman!.nama,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: edit,
                        child: Icon(Icons.edit),
                      ),
                      SizedBox(width: 15,),
                      InkWell(
                        onTap: delete,
                        child: Icon(Icons.delete),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8),
              Image.network(
                favorit.fields.restoran != null
                  ? favorit.fields.restoran!.gambar
                  : favorit.fields.makanan != null
                    ? favorit.fields.makanan!.gambar
                    : favorit.fields.minuman!.gambar,
                errorBuilder: (context, error, stackTrace) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.error),
                          Text('Error loading image')
                        ],
                      )
                    ],
                  );
                },
              ),
              if (favorit.fields.catatan != "")
                Column(
                  children: [
                    SizedBox(height: 8),
                    Text('Catatan: ${favorit.fields.catatan}'),
                  ],
                ),
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
