import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/screens/makanan/makanan_edit.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';

class RPMakananDetail extends StatefulWidget {
  final Makanan makanan;

  const RPMakananDetail({
    super.key,
    required this.makanan,
  });

  @override
  _RPMakananDetailState createState() => _RPMakananDetailState();
}

class _RPMakananDetailState extends State<RPMakananDetail> {
  MakananService makananService = MakananService();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    Makanan makanan = widget.makanan;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
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
                    '${RPUrls.baseUrl}${makanan.gambar}',
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
              makanan.nama,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: RPColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              makanan.deskripsi,
              style: const TextStyle(
                fontSize: 18.0,
                color: RPColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              'Rp${makanan.harga.toStringAsFixed(0)}',
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Restoran',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      makanan.restoran.nama,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: RPColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      makanan.restoran.alamat,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: RPColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Telepon: ${makanan.restoran.nomorTelepon}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: RPColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Jam Operasional: ${makanan.restoran.jamBuka} - ${makanan.restoran.jamTutup}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: RPColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}