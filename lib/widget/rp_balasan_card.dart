import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/balasan.dart';
import 'package:rasapalembang/screens/authentication/profile.dart';
import 'package:rasapalembang/services/balasan_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/date_time_extension.dart';
import 'package:rasapalembang/utils/rp_cache.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';
import 'package:rasapalembang/widget/rp_image_error.dart';
import 'package:rasapalembang/widget/rp_image_loading.dart';

class RPBalasanCard extends StatefulWidget {
  final Balasan balasan;
  final VoidCallback refreshList;
  final Function(Balasan) editBalasan;

  const RPBalasanCard({
    super.key,
    required this.balasan,
    required this.refreshList,
    required this.editBalasan,
  });

  @override
  _RPBalasanCardState createState() => _RPBalasanCardState();
}

class _RPBalasanCardState extends State<RPBalasanCard> {
  late BalasanService balasanService;

  @override
  void initState() {
    super.initState();
    balasanService = BalasanService();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    bool isBalasanUser = request.user?.username == widget.balasan.user.username;
    return GestureDetector(
      onLongPress: () {
        HapticFeedback.lightImpact();
        _showBalasanOption(context, widget.balasan, isBalasanUser, request);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: 2.0),
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.balasan.user.foto != ''
                      ? RPUrls.baseUrl + widget.balasan.user.foto
                      : RPUrls.noProfileUrl,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => RPImageLoading(),
                  errorWidget: (context, url, error) => RPImageError(),
                  cacheManager: RPCache.rpCacheManager,
                ),
              ),
            ],
          ),
          SizedBox(width: 8.0),
          Expanded(
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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.balasan.user.nama,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(widget.balasan.pesan),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          widget.balasan.tanggalPosting.timeAgo(),
                          style: TextStyle(
                            color: RPColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  void _showBalasanOption(BuildContext context, Balasan balasan,
      bool isBalasanUser, UserService request) {
    RPBottomSheet(
      context: context,
      widgets: [
        ListTile(
          leading: const Icon(Icons.person_search_rounded),
          title: const Text('Lihat profil'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  username: balasan.user.username,
                  nama: balasan.user.nama,
                  deskripsi: balasan.user.deskripsi,
                  peran: balasan.user.peran,
                  foto: balasan.user.foto,
                  poin: balasan.user.poin,
                  dateJoined: balasan.user.dateJoined,
                  loggedInUsername: request.user?.username,
                ),
              ),
            );
          },
        ),
        if (isBalasanUser)
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit balasan'),
            onTap: () {
              Navigator.pop(context);
              widget.editBalasan(balasan);
            },
          ),
        if (isBalasanUser)
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: RPColors.merahMuda,
            ),
            title: const Text(
              'Hapus balasan',
              style: TextStyle(
                color: RPColors.merahMuda,
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              String message;
              try {
                await balasanService.deleteBalasan(balasan);
                message = 'Balasan berhasil dihapus.';
                widget.refreshList();
              } catch (e) {
                message = e.toString();
              }

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            },
          ),
      ],
    ).show();
  }
}
