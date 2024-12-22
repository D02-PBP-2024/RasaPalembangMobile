import 'package:flutter/material.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/screens/favorit/route.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/format_harga.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/restoran_detail.dart';
import 'package:rasapalembang/widget/rp_button.dart';

import '../models/favorit.dart';
import '../services/favorit_service.dart';

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

  final FavoritService favoritService = FavoritService();
  List<Favorit> favoritList = [];
  bool isFavorited = false;
  String favoritePK = "";

  @override
  void initState() {
    super.initState();
    _isInFavorite();
  }

  Future<void> _isInFavorite() async {
    favoritList = await favoritService.get();
    for (var i in favoritList) {
      if (i.fields.minuman != null ) {
        if (i.fields.minuman!.pk == widget.minuman.pk) {
          setState(() {
            isFavorited = true;
            favoritePK = i.pk;
          });
          break;
        }
      }
    }
  }

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
                  child: Image.network(
                    '${RPUrls.baseUrl}${minuman.gambar}',
                    width: double.infinity,
                    height: screenWidth - 32,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () async {
                      // TODO: menambah ke favorit
                      String? newPK = await favoritService.add(widget.minuman.pk!, "minuman");
                        if (newPK != null) {
                          setState(() {
                            isFavorited = true;
                            favoritePK = newPK;
                          });
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) => FavoritRoute()));
                        }
                    },
                    child: CircleAvatar(
                      backgroundColor: isFavorited ? Colors.red : Colors.black,
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
