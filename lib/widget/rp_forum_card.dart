import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/screens/forum/forum_edit.dart';
import 'package:rasapalembang/services/forum_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/date_time_extension.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';

class RPForumCard extends StatelessWidget {
  final String topik;
  final String pesan;
  final DateTime tanggalPosting;
  final String user;
  final String restoran;
  final Forum forum;
  final VoidCallback onTap;

  RPForumCard({
    super.key,
    required this.topik,
    required this.pesan,
    required this.tanggalPosting,
    required this.user,
    required this.restoran,
    required this.forum,
    required this.onTap,
  });

  ForumService forumService = ForumService();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    bool isForumUser = request.user?.username == forum.user.username;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      topik,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (isForumUser)
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        _showForumOption(context);
                      },
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                pesan,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14, color: RPColors.textSecondary),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Diunggah oleh $user",
                    style: const TextStyle(
                        fontSize: 12, color: RPColors.textSecondary),
                  ),
                  Text(
                    tanggalPosting.timeAgo(),
                    style: const TextStyle(
                        fontSize: 12, color: RPColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showForumOption(BuildContext context) {
    List<BottomSheetOption> options = [
      BottomSheetOption(
        icon: Icons.edit,
        title: 'Edit forum',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForumEditPage(
                topik: topik,
                pesan: pesan,
                restoran: restoran,
              ),
            ),
          );
        },
      ),
      BottomSheetOption(
        icon: Icons.delete,
        title: 'Hapus forum',
        textColor: RPColors.merahMuda,
        iconColor: RPColors.merahMuda,
        onTap: () async {
          String message;
          try {
            final response = await forumService.deleteForum(forum);
            message = 'Forum berhasil dihapus';
          } catch (e) {
            message =
                'Terjadi kesalahan: ${e.toString()}';
          }

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
            Navigator.pop(context);
          }
        },
      ),
    ];

    RPBottomSheet(context: context, options: options).show();
  }
}
