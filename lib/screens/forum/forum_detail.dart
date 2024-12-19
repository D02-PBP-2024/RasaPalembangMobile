import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk memformat tanggal
import 'package:rasapalembang/models/balasan.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/services/balasan_service.dart';

class ForumDetailPage extends StatelessWidget {
  final Forum forum;

  const ForumDetailPage({super.key, required this.forum});

  @override
  Widget build(BuildContext context) {
    BalasanService balasanService = BalasanService();

    return Scaffold(
      appBar: AppBar(
        title: Text(forum.topik),
      ),
      body: FutureBuilder<List<Balasan>>(
        future: balasanService.get(forum.pk),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada balasan."));
          } else {
            final balasanList = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    forum.pesan,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: balasanList.length,
                    itemBuilder: (context, index) {
                      final balasan = balasanList[index];
                      return ListTile(
                        leading: const Icon(
                            Icons.person), // TODO: bisa ganti gambar user juga
                        title: Text(
                          "User: ${balasan.user.username}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(balasan.pesan),
                            Text(
                              DateFormat('dd MMM yyyy, HH:mm')
                                  .format(balasan.tanggalPosting),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
