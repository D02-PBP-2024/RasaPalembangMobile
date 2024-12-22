import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/ulasan.dart';
import 'package:rasapalembang/screens/authentication/profile.dart';
import 'package:rasapalembang/screens/ulasan/ulasan_edit.dart';
import 'package:rasapalembang/services/ulasan_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/utils/rp_cache.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';
import 'package:rasapalembang/widget/rp_image_error.dart';
import 'package:rasapalembang/widget/rp_image_loading.dart';

class RPUlasanCard extends StatelessWidget {
  final Ulasan ulasan;
  final VoidCallback refreshList;
  final includeResto;

  RPUlasanCard({
    super.key,
    required this.ulasan,
    required this.refreshList,
    this.includeResto = false,
  });

  final UlasanService ulasanService = UlasanService();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    bool isUlasanUser = request.user?.username == ulasan.user.username;

    return GestureDetector(
      onLongPress: () {
        HapticFeedback.lightImpact();
        _showUlasanOption(context, isUlasanUser, request);
      },
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: Colors.grey[300]!,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: ulasan.user.foto != ''
                          ? RPUrls.baseUrl + ulasan.user.foto
                          : RPUrls.noProfileUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => RPImageLoading(),
                      errorWidget: (context, url, error) => RPImageError(),
                      cacheManager: RPCache.rpCacheManager,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ulasan.user.nama,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        DateFormat('dd MMM yyyy, HH:mm', 'id_ID')
                            .format(ulasan.createdAt.toLocal()),
                        style: TextStyle(
                          color: RPColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        ulasan.restoran,
                        style: TextStyle(
                          color: RPColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              // bintang nilai
              RatingBar.builder(
                itemSize: 24,
                initialRating: ulasan.nilai.toDouble(),
                itemCount: 5,
                unratedColor: Colors.grey,
                ignoreGestures: true,
                itemBuilder: (context, index) => Icon(
                  Icons.star_rounded,
                  color: index < ulasan.nilai.toDouble()
                      ? Colors.amber
                      : Colors.grey,
                ),
                onRatingUpdate: (rating) {},
              ),
              SizedBox(height: 8.0),
              // ulasan
              Text(ulasan.deskripsi),
            ],
          ),
        ),
      ),
    );
  }

  void _showUlasanOption(
      BuildContext context, bool isUlasanUser, UserService request) {
    RPBottomSheet(
      context: context,
      widgets: [
        ListTile(
          leading: Icon(Icons.person_search_rounded),
          title: Text('Lihat profil'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  username: ulasan.user.username,
                  nama: ulasan.user.nama,
                  deskripsi: ulasan.user.deskripsi,
                  peran: ulasan.user.peran,
                  foto: ulasan.user.foto,
                  poin: ulasan.user.poin,
                  dateJoined: ulasan.user.dateJoined,
                  loggedInUsername: request.user?.username,
                ),
              ),
            );
          },
        ),
        if (isUlasanUser)
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit ulasan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UlasanEditPage(
                    ulasan: ulasan,
                  ),
                ),
              );
              refreshList();
            },
          ),
        if (isUlasanUser)
          ListTile(
            leading: Icon(
              Icons.delete,
              color: RPColors.merahMuda,
            ),
            title: Text(
              'Hapus ulasan',
              style: TextStyle(
                color: RPColors.merahMuda,
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              String message;
              try {
                await ulasanService.deleteUlasan(ulasan);
                message = 'Ulasan berhasil dihapus';
              } catch (e) {
                message = printException(e as Exception);
              }

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              }
              refreshList();
            },
          ),
      ],
    ).show();
  }
}
