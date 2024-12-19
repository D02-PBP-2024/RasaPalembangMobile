import 'package:flutter/material.dart';
import 'dart:io';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class RPRestoCard extends StatelessWidget {
  final String nama;
  final String gambar;
  final String rating;
  final String jamBuka;
  final String jamTutup;
  final bool isOpen;

  const RPRestoCard({
    super.key,
    required this.nama,
    required this.gambar,
    required this.rating,
    required this.jamBuka,
    required this.jamTutup,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Restoran
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
            child: gambar.isNotEmpty
                ? Image.network(
              RPUrls.baseUrl + gambar,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            )
                : Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey[300],
              child: const Icon(
                Icons.image_not_supported,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Restoran
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                // Rating
                Text(
                  '($rating/5.0)',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                // Jam Operasional
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '$jamBuka - $jamTutup',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: Text(
                        isOpen ? 'Buka' : 'Tutup',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: isOpen ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
