import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/models/balasan.dart';
import 'package:rasapalembang/services/balasan_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/date_time_extension.dart';
import 'package:rasapalembang/utils/urls_constants.dart';

class ForumDetailPage extends StatelessWidget {
  final Forum forum;

  ForumDetailPage({super.key, required this.forum});

  @override
  Widget build(BuildContext context) {
    BalasanService balasanService = BalasanService();
    final request = context.watch<UserService>();

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
          } else {
            final balasanList = snapshot.data ?? [];
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Row(
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
                const SizedBox(height: 16),
                Text(
                  forum.pesan,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0, top: 2.0),
                      child: const Icon(Icons.message),
                    ),
                    Text(
                      "${balasanList.length}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (balasanList.isEmpty)
                  const Center(child: Text("Belum ada balasan."))
                else
                  Column(
                    children: balasanList.map((balasan) {
                      return Card(
                        elevation: 2.0,
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      balasan.user.foto != ""
                                          ? RPUrls.baseUrl + balasan.user.foto
                                          : RPUrls.noProfileUrl,
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          balasan.user.username,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          balasan.tanggalPosting.timeAgo(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(balasan.pesan),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
