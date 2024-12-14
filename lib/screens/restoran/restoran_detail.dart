import 'package:flutter/material.dart';
import 'package:rasapalembang/models/restoran.dart';

class RestoranDetailPage extends StatelessWidget {
  final Restoran restoran;

  const RestoranDetailPage({
    super.key,
    required this.restoran,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restoran.fields.nama),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (restoran.fields.gambar.isNotEmpty)
                Image.network(
                  restoran.fields.gambar,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              Text(
                restoran.fields.nama,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text("Alamat: ${restoran.fields.alamat}"),
              const SizedBox(height: 8),
              Text(
                  "Jam Buka: ${restoran.fields.jamBuka} - ${restoran.fields.jamTutup}"),
              const SizedBox(height: 8),
              Text(
                  "Nomor Telepon: ${restoran.fields.nomorTelepon.isNotEmpty ? restoran.fields.nomorTelepon : 'Tidak tersedia'}"),
            ],
          ),
        ),
      ),
    );
  }
}
