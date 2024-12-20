import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/screens/forum/forum_detail.dart';
import 'package:rasapalembang/screens/forum/forum_tambah.dart';
import 'package:rasapalembang/services/forum_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/widget/rp_forum_card.dart';
import 'package:rasapalembang/widget/rp_floatingbutton.dart';

class ForumListPage extends StatefulWidget {
  final String idRestoran;

  const ForumListPage({super.key, required this.idRestoran});

  @override
  State<ForumListPage> createState() => _ForumListPageState();
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
      _forumFuture = forumService.get(widget.idRestoran).then((forumList) {
        forumList.sort((a, b) => b.tanggalPosting.compareTo(a.tanggalPosting));
        return forumList;
      });
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
                  forum: forum,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForumDetailPage(forum: forum),
                      ),
                    );
                  },
                  refreshList: _loadForumList,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: (request.loggedIn)
          ? RPFloatingButton(
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
              icon: const Icon(Icons.add_comment, color: Colors.white),
              tooltip: 'Tambah Forum',
            )
          : null,
    );
  }
}
