import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/screens/authentication/profile.dart';
import 'package:rasapalembang/screens/forum/forum_edit.dart';
import 'package:rasapalembang/services/forum_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/date_time_extension.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';

class RPForumCard extends StatelessWidget {
  final Forum forum;
  final VoidCallback onTap;
  final VoidCallback refreshList;

  RPForumCard({
    super.key,
    required this.forum,
    required this.onTap,
    required this.refreshList,
  });

  ForumService forumService = ForumService();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    bool isForumUser = request.user?.username == forum.user.username;

    return GestureDetector(
      onTap: onTap,
      onLongPress: () {
        HapticFeedback.lightImpact();
        _showForumOption(context, isForumUser, request);
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
                    child: Image.network(
                      forum.user.foto != ''
                          ? RPUrls.baseUrl + forum.user.foto
                          : RPUrls.noProfileUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        forum.user.nama,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        forum.tanggalPosting.timeAgo(),
                        style: TextStyle(
                          color: RPColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      forum.topik,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                forum.pesan,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14, color: RPColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showForumOption(BuildContext context, bool isForumUser, UserService request) {
    RPBottomSheet(
      context: context,
      widgets: [
        ListTile(
          leading: Icon(Icons.person_search_rounded),
          title: Text('Lihat profil'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push( // TODO: Tangani buat tanda balik ke halaman sebelumnya
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  username: forum.user.username,
                  nama: forum.user.nama,
                  deskripsi: forum.user.deskripsi,
                  peran: forum.user.peran,
                  foto: forum.user.foto,
                  poin: forum.user.poin,
                  dateJoined: forum.user.dateJoined,
                  loggedInUsername: request.user?.username,
                ),
              ),
            );
          },
        ),
        if (isForumUser)
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Edit forum'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForumEditPage(
                  forum: forum,
                ),
              ),
            );
            refreshList();
          },
        ),
        if (isForumUser)
        ListTile(
          leading: Icon(
            Icons.delete,
            color: RPColors.merahMuda,
          ),
          title: Text(
            'Hapus forum',
            style: TextStyle(
              color: RPColors.merahMuda,
            ),
          ),
          onTap: () async {
            Navigator.pop(context);
            String message;
            try {
              final response = await forumService.deleteForum(forum);
              message = 'Forum berhasil dihapus';
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
