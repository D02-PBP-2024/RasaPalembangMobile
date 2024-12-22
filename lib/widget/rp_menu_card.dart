import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/format_harga.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

import '../models/favorit.dart';
import '../services/favorit_service.dart';

class RPMenuCard extends StatefulWidget {
  final String id;
  final String gambar;
  final String nama;
  final int harga;
  final String restoran;

  const RPMenuCard({
    super.key,
    required this.id,
    required this.gambar,
    required this.nama,
    required this.harga,
    required this.restoran,
  });

  @override
  State<RPMenuCard> createState() => _RPMenuCardState();
}

class _RPMenuCardState extends State<RPMenuCard> {
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
    for (var favorit in favoritList) {
      final minuman = favorit.fields.minuman;
      final makanan = favorit.fields.makanan;

      // Check if either minuman or makanan matches the widget ID
      if ((minuman != null && minuman.pk == widget.id) ||
          (makanan != null && makanan.pk == widget.id)) {
        setState(() {
          isFavorited = true;
          favoritePK = favorit.pk;
        });
        break;
      }
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                child: Image.network(
                  '${RPUrls.baseUrl}${widget.gambar}',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned(
              //   top: 4,
              //   right: 4,
              //   child: GestureDetector(
              //     onTap: () async {
              //       // TODO: menambah ke favorit
              //       if (!isFavorited) {
              //         String? newPK = await favoritService.add(widget.id, "makanan");
              //         newPK ??  await favoritService.add(widget.id, "minuman");
              //         if (newPK != null) {
              //           setState(() {
              //             isFavorited = true;
              //             favoritePK = newPK;
              //           });
              //         }
              //       } else {
              //         bool isDeleted = await favoritService.delete(favoritePK);
              //         if (isDeleted) {
              //           setState(() {
              //             isFavorited = false;
              //             favoritePK = "";
              //           });
              //         } 
              //       }
              //     },
              //     child: CircleAvatar(
              //       backgroundColor: isFavorited ? Colors.red : Colors.black,
              //       child: Icon(
              //         Icons.favorite_border,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.nama,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  widget.restoran,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: RPColors.textSecondary,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  FormatHarga.format(widget.harga),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: RPColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
