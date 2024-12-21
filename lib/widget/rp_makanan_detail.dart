import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/format_harga.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_restoran_detail.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FormatHarga.format(makanan.harga),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: RPColors.textPrimary,
                  ),
                ),
                // kasih spasi di sini
                Row(
                  children: [
                    
                    SizedBox(width: 8.0),
                    _infoCard('${makanan.kalori} kkal', Icons.dining_outlined),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            RPButton(
              label: 'Lihat Restoran',
              width: double.infinity,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RPRestoDetail(
                        restoran: widget.makanan.restoran
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String text, IconData icon) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18.0,
            ),
            SizedBox(width: 4.0),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}