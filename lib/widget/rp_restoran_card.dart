import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/utils/is_open.dart';
import 'package:rasapalembang/utils/rp_cache.dart';
import 'package:rasapalembang/utils/size_constants.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/restoran_detail.dart';
import 'package:rasapalembang/widget/rp_image_error.dart';
import 'package:rasapalembang/widget/rp_image_loading.dart';

class RPRestoCard extends StatefulWidget {
  final Restoran restoran;

  const RPRestoCard({
    super.key,
    required this.restoran,
  });

  @override
  _RPRestoCardState createState() => _RPRestoCardState();
}

class _RPRestoCardState extends State<RPRestoCard> {
  @override
  Widget build(BuildContext context) {
    Restoran restoran = widget.restoran;
    bool isOpen = isCurrentlyOpen(restoran.jamBuka, restoran.jamTutup);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestoranDetail(restoran: restoran),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RPSize.cornerRadius),
          side: BorderSide(
            color: Colors.grey[300]!,
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Restoran
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8.0)),
                  child: restoran.gambar.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: RPUrls.baseUrl + restoran.gambar,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => RPImageLoading(),
                          errorWidget: (context, url, error) => RPImageError(),
                          cacheManager: RPCache.rpCacheManager,
                        )
                      : Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey,
                          ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Restoran
                  Text(
                    restoran.nama,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  // Rating
                  RatingBar.builder(
                    initialRating: widget.restoran.rating ?? 0.0,
                    itemSize: 20,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    unratedColor: Colors.grey,
                    itemBuilder: (context, index) => Icon(
                      Icons.star_rounded,
                      color: index < (widget.restoran.rating ?? 0)
                          ? Colors.amber
                          : Colors.grey,
                    ),
                    onRatingUpdate: (rating) { },
                  ),
                  const SizedBox(height: 4.0),
                  // Jam Operasional
                  Row(
                    children: [
                      Text(
                        '${restoran.jamBuka} - ${restoran.jamTutup}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        isOpen ? 'Buka' : 'Tutup',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: isOpen ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
