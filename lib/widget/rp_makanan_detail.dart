import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class RPMakananDetail extends StatelessWidget {
  final String nama;
  final String deskripsi;
  final String gambar;
  final int harga;
  final int kalori;
  final String kategori;
  final String namaRestoran;
  final String alamatRestoran;
  final String nomorTeleponRestoran;
  final String jamBukaRestoran;
  final String jamTutupRestoran;

  const RPMakananDetail({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.gambar,
    required this.harga,
    required this.kategori,
    required this.kalori,
    required this.namaRestoran,
    required this.alamatRestoran,
    required this.nomorTeleponRestoran,
    required this.jamBukaRestoran,
    required this.jamTutupRestoran,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: RPColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                deskripsi,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: RPColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20.0),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      gambar,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: menambah ke favorit
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Detail Minuman',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 16.0),
              _buildDetailRow(Icons.attach_money, 'Harga', 'Rp${harga.toStringAsFixed(0)}'),
              _buildDetailRow(Icons.category, 'Kategori', kategori),
              _buildDetailRow(Icons.star, 'Kalori', '$kalori%'),
              const SizedBox(height: 20.0),
              const Text(
                'Informasi Restoran',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 12.0),
              GestureDetector(
                onTap: () {
                  //TODO: navigasi ke halaman restoran di sini
                },
                child: Text(
                  namaRestoran,
                  style: const TextStyle(
                    fontSize: 20,
                    color: RPColors.biruMuda,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              _buildDetailRow(Icons.location_on, 'Alamat', alamatRestoran),
              _buildDetailRow(Icons.phone, 'Telepon', nomorTeleponRestoran),
              _buildDetailRow(Icons.access_time, 'Jam Operasional', '$jamBukaRestoran - $jamTutupRestoran'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: RPColors.biruMuda,
            size: 24,
          ),
          const SizedBox(width: 8.0),
          Text(
            '$label: $value',
            style: const TextStyle(
              fontSize: 16.0,
              color: RPColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}