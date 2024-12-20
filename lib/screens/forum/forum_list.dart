import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/screens/forum/forum_detail.dart';
import 'package:rasapalembang/screens/forum/forum_tambah.dart';
import 'package:rasapalembang/services/forum_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/widget/rp_forum_card.dart';

class ForumListPage extends StatefulWidget {
  final String idRestoran;

  ForumListPage({super.key, required this.idRestoran});

  @override
  _ForumListPageState createState() => _ForumListPageState();
}

class _ForumListPageState extends State<ForumListPage> {
  late Future<List<Forum>> _forumFuture;
  late ForumService forumService;

  @override
  void initState() {
    super.initState();
    forumService = ForumService();
    _loadForumList();
  }

  void _loadForumList() {
    setState(() {
      _forumFuture = forumService.get(widget.idRestoran);
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum Diskusi"),
      ),
      body: FutureBuilder<List<Forum>>(
        future: _forumFuture,
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
                  topik: forum.topik,
                  pesan: forum.pesan,
                  tanggalPosting: forum.tanggalPosting,
                  user: forum.user.username,
                  restoran: forum.restoran,
                  forum: forum,
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
      floatingActionButton: (request.loggedIn)
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForumTambahPage(
                      restoran: widget.idRestoran,
                    ),
                  ),
                );
                _loadForumList();
              },
              child: const Icon(Icons.add),
              tooltip: 'Tambah Forum',
            )
          : null,
    );
  }
}
