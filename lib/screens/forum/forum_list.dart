import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/screens/authentication/show_login_bottom.dart';
import 'package:rasapalembang/screens/forum/forum_detail.dart';
import 'package:rasapalembang/screens/forum/forum_tambah.dart';
import 'package:rasapalembang/services/forum_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/widget/rp_floatingbutton.dart';
import 'package:rasapalembang/widget/rp_forum_card.dart';
import 'package:rasapalembang/widget/rp_forum_card_skeleton.dart';
import 'package:rasapalembang/widget/rp_list_view.dart';

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder<List<Forum>>(
          future: _forumFuture,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildForumList(
                itemCount: 4,
                isLoading: true,
                request: request,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Belum ada diskusi."));
            } else {
              return _buildForumList(
                itemCount: snapshot.data.length,
                isLoading: false,
                data: snapshot.data,
                request: request,
              );
            }
          },
        ),
      ),
      floatingActionButton: request.user?.peran != 'pemilik_restoran'
          ? RPFloatingButton(
              onPressed: () async {
                if (request.loggedIn) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForumTambahPage(
                        restoran: widget.idRestoran,
                      ),
                    ),
                  );
                  _loadForumList();
                } else {
                  showLoginBottom(context);
                }
              },
              icon: const Icon(Icons.add_comment, color: Colors.white),
              tooltip: 'Tambah Forum',
            )
          : null,
    );
  }

  Widget _buildForumList(
      {required int itemCount, bool isLoading = false, List? data, required UserService request}) {
    return RPListView(
      paddingBottom: request.user?.peran != 'pemilik_restoran' ? 80.0 : 8.0,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (isLoading) {
          return Column(
            children: [
              RPForumCardSkeleton(),
              if (index < itemCount - 1) SizedBox(height: 8.0),
            ],
          );
        } else {
          final forum = data![index];
          return Column(
            children: [
              RPForumCard(
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
              ),
              if (index < itemCount - 1) SizedBox(height: 8.0),
            ],
          );
        }
      }
    );
  }
}
