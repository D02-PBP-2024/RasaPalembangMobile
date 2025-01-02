import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/format_harga.dart';
import 'package:rasapalembang/utils/rp_cache.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/restoran_detail.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_favorit_button.dart';
import 'package:rasapalembang/widget/rp_image_error.dart';
import 'package:rasapalembang/widget/rp_image_loading.dart';

class RPMinumanDetail extends StatefulWidget {
  final Minuman minuman;
  final bool lihatRestoran;

  const RPMinumanDetail({
    super.key,
    required this.minuman,
    this.lihatRestoran = true,
  });

  @override
  State<RPMinumanDetail> createState() => _RPMinumanDetailState();
}

class _RPMinumanDetailState extends State<RPMinumanDetail> {
  MinumanService minumanService = MinumanService();

  @override
  Widget build(BuildContext context) {
    Minuman minuman = widget.minuman;
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
                  child: CachedNetworkImage(
                    imageUrl: '${RPUrls.baseUrl}${minuman.gambar}',
                    width: double.infinity,
                    height: screenWidth - 32,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => RPImageLoading(),
                    errorWidget: (context, url, error) => RPImageError(),
                    cacheManager: RPCache.rpCacheManager,
                  ),
                ),
                RPFavoritButton(
                  favorit: minuman.favorit,
                  minuman: minuman
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              minuman.nama,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: RPColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              minuman.deskripsi,
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
                  FormatHarga.format(minuman.harga),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: RPColors.textPrimary,
                  ),
                ),
                // kasih spasi di sini
                Row(
                  children: [
                    _infoCard(_title(minuman.ukuran), Icons.wine_bar),
                    SizedBox(width: 8.0),
                    _infoCard('${minuman.tingkatKemanisan}% Gula', Icons.speed),
                  ],
                ),
              ],
            ),
            if (widget.lihatRestoran)
              Column(
                children: [
                  const SizedBox(height: 20.0),
                  RPButton(
                    label: 'Lihat Restoran',
                    width: double.infinity,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RestoranDetail(restoran: widget.minuman.restoran),
                        ),
                      );
                    },
                  ),
                ],
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

  String _title(String string) {
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }
}
