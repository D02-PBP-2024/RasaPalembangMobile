import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class ForumDetailPage extends StatelessWidget {
  final Forum forum;

  const ForumDetailPage({super.key, required this.forum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Forum"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              forum.fields.topik,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dikirim oleh: User ${forum.fields.user}",
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: RPColors.textSecondary,
                  ),
                ),
                Text(
                  "Tanggal: ${DateFormat('dd MMMM yyyy').format(forum.fields.tanggalPosting)}",
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: RPColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              forum.fields.pesan,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
