import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk memformat tanggal
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/models/balasan.dart';
import 'package:rasapalembang/services/balasan_service.dart';
import 'package:rasapalembang/utils/date_time_extension.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_forum_card.dart';

class ForumDetailPage extends StatelessWidget {
  final Forum forum;

  ForumDetailPage({super.key, required this.forum});

  @override
  Widget build(BuildContext context) {
    BalasanService balasanService = BalasanService();

    return Scaffold(
      appBar: AppBar(
        title: Text(forum.topik),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pemilik Forum
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    forum.user.foto != ""
                        ? RPUrls.baseUrl + forum.user.foto
                        : RPUrls.noProfileUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        forum.user.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Tanggal Forum
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          forum.tanggalPosting.timeAgo(),
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Pesan Forum
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              forum.pesan,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Divider(),
          ),

          // Total Balasan (Icon Pesan Tetap Ada)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: const Icon(Icons.message),
                ),
                const SizedBox(width: 6),
                FutureBuilder<List<Balasan>>(
                  future: balasanService.get(forum.pk),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Memuat...");
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text("0");
                    } else {
                      return Text("${snapshot.data!.length}");
                    }
                  },
                ),
              ],
            ),
          ),

          // Daftar Balasan
          Expanded(
            child: FutureBuilder<List<Balasan>>(
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
                  return ListView.builder(
                    itemCount: balasanList.length,
                    itemBuilder: (context, index) {
                      final balasan = balasanList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Foto User
                                Align(
                                  alignment: Alignment.center,
                                  child: ClipOval(
                                    child: Image.network(
                                      forum.user.foto != ""
                                          ? RPUrls.baseUrl + balasan.user.foto
                                          : RPUrls.noProfileUrl,
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),

                                // Box untuk Nama dan Tanggal
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Nama User
                                      Text(
                                        balasan.user.username,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Tanggal Balasan
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          balasan.tanggalPosting.timeAgo(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Pesan Balasan
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 58.0, right: 16.0),
                              child: Text(balasan.pesan),
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
