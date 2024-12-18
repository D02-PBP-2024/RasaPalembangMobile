import 'package:flutter/material.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/screens/forum/forum_detail.dart';
import 'package:rasapalembang/services/forum_service.dart';
import 'package:rasapalembang/widget/rp_forum_card.dart';

class ForumListPage extends StatelessWidget {
  final String idRestoran;

  ForumListPage({super.key, required this.idRestoran});

  @override
  Widget build(BuildContext context) {
    ForumService forumService = ForumService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum Diskusi"),
      ),
      body: FutureBuilder<List<Forum>>(
        future: forumService.get(idRestoran),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada diskusi."));
          } else {
            final forumList = snapshot.data!;

            return ListView.builder(
              itemCount: forumList.length,
              itemBuilder: (context, index) {
                final forum = forumList[index];
                return RPForumCard(
                  topik: forum.fields.topik,
                  pesan: forum.fields.pesan,
                  tanggalPosting: forum.fields.tanggalPosting,
                  user: "userDummy", // TODO: masih userDummy, nanti benerin lagi
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForumDetailPage(forum: forum),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
