import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/date_time_extension.dart';

class RPForumCard extends StatelessWidget {
  final String topik;
  final String pesan;
  final DateTime tanggalPosting;
  final String user;
  final VoidCallback onTap;

  const RPForumCard({
    super.key,
    required this.topik,
    required this.pesan,
    required this.tanggalPosting,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
              Text(
                topik,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                pesan,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: RPColors.textSecondary),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Diunggah oleh $user",
                    style: const TextStyle(fontSize: 12, color: RPColors.textSecondary),
                  ),
                  Text(
                    tanggalPosting.timeAgo(),
                    style: const TextStyle(fontSize: 12, color: RPColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
