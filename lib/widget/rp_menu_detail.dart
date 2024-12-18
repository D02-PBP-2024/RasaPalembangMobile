import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class RPMenuDetail extends StatelessWidget {
  final String nama;
  final String deskripsi;
  final String gambar;
  final int harga;
  final String ukuran;
  final int tingkatKemanisan;
  final String namaRestoran;
  final String alamatRestoran;
  final String nomorTeleponRestoran;
  final String jamBukaRestoran;
  final String jamTutupRestoran;

  const RPMenuDetail({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.gambar,
    required this.harga,
    required this.ukuran,
    required this.tingkatKemanisan,
    required this.namaRestoran,
    required this.alamatRestoran,
    required this.nomorTeleponRestoran,
    required this.jamBukaRestoran,
    required this.jamTutupRestoran,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      '${RPUrls.baseUrl}$gambar',
                      width: double.infinity,
                      height: screenWidth - 32,
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
              Text(
                nama,
                style: const TextStyle(
                  fontSize: 24.0,
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
              const SizedBox(height: 12.0),
              Text(
                'Rp${harga.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: RPColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20.0),
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Informasi Restoran'),
                    ],
                  ),
                ),
              ),
              // const Text(
              //   'Informasi Restoran',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold
              //   ),
              // ),
              // const SizedBox(height: 12.0),
              // GestureDetector(
              //   onTap: () {
              //     //TODO: navigasi ke halaman restoran di sini
              //   },
              //   child: Text(
              //     namaRestoran,
              //     style: const TextStyle(
              //       fontSize: 20,
              //       color: RPColors.biruMuda,
              //       fontWeight: FontWeight.bold
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 12.0),
              // _buildDetailRow(Icons.location_on, 'Alamat', alamatRestoran),
              // _buildDetailRow(Icons.phone, 'Telepon', nomorTeleponRestoran),
              // _buildDetailRow(Icons.access_time, 'Jam Operasional', '$jamBukaRestoran - $jamTutupRestoran'),
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
