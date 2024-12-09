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
        title: Text(restoran.nama),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (restoran.gambar != null && restoran.gambar!.isNotEmpty)
                Image.network(
                  restoran.gambar!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              Text(
                restoran.nama,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text("Alamat: ${restoran.alamat}"),
              const SizedBox(height: 8),
              Text("Jam Buka: ${restoran.jamBuka} - ${restoran.jamTutup}"),
              const SizedBox(height: 8),
              Text("Nomor Telepon: ${restoran.nomorTelepon ?? 'Tidak tersedia'}"),
            ],
          ),
        ),
      ),
    );
  }
}
