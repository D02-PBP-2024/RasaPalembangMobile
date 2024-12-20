import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/models/balasan.dart';
import 'package:rasapalembang/screens/authentication/profile.dart';
import 'package:rasapalembang/screens/forum/balasan_edit.dart';
import 'package:rasapalembang/services/balasan_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/date_time_extension.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';

class ForumDetailPage extends StatefulWidget {
  final Forum forum;

  const ForumDetailPage({super.key, required this.forum});

  @override
  State<ForumDetailPage> createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  late Future<List<Balasan>> _balasanFuture;
  late BalasanService balasanService;

  final TextEditingController _balasanController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isTypingBalasan = false;

  @override
  void initState() {
    super.initState();
    balasanService = BalasanService();
    _loadBalasanList();
  }

  @override
  void dispose() {
    _balasanController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _loadBalasanList() {
    setState(() {
      _balasanFuture = balasanService.get(widget.forum.pk);
    });
  }

  void _sendBalasan() async {
    if (_balasanController.text.trim().isEmpty) return;

    try {
      await balasanService.addBalasan(
        _balasanController.text.trim(),
        widget.forum.pk,
      );
      _balasanController.clear();
      setState(() {
        _isTypingBalasan = false;
      });
      _loadBalasanList();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.forum.topik),
      ),
      body: FutureBuilder<List<Balasan>>(
        future: _balasanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final balasanList = snapshot.data ?? [];
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              widget.forum.user.foto != ""
                                  ? RPUrls.baseUrl + widget.forum.user.foto
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
                                  widget.forum.user.username,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    widget.forum.tanggalPosting.timeAgo(),
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
                        widget.forum.pesan,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          if (request.loggedIn) {
                            setState(() {
                              _isTypingBalasan = true;
                            });
                            _focusNode.requestFocus();
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.message),
                            const SizedBox(width: 4),
                            Text(
                              "${balasanList.length}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (balasanList.isEmpty)
                        const Center(child: Text("Belum ada balasan."))
                      else
                        Column(
                          children: balasanList.reversed.map((balasan) {
                            bool isBalasanUser =
                                request.user?.username == balasan.user.username;
                            return GestureDetector(
                              onLongPress: () {
                                HapticFeedback.lightImpact();
                                _showBalasanOption(
                                    context, balasan, isBalasanUser);
                              },
                              child: Card(
                                elevation: 2.0,
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                              balasan.user.foto != ""
                                                  ? RPUrls.baseUrl +
                                                      balasan.user.foto
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  balasan.tanggalPosting
                                                      .timeAgo(),
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
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                if (_isTypingBalasan)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _balasanController,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              hintText: "Ketik balasan...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.blue),
                          onPressed: _sendBalasan,
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }

  void _showBalasanOption(
      BuildContext context, Balasan balasan, bool isBalasanUser) {
    RPBottomSheet(
      context: context,
      widgets: [
        ListTile(
          leading: const Icon(Icons.person_search_rounded),
          title: const Text('Lihat profil'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  username: balasan.user.username,
                  nama: balasan.user.nama,
                  deskripsi: balasan.user.deskripsi,
                  peran: balasan.user.peran,
                  foto: balasan.user.foto,
                  poin: balasan.user.poin,
                  dateJoined: balasan.user.dateJoined,
                  loggedInUsername: balasan.user.username,
                ),
              ),
            );
          },
        ),
        if (isBalasanUser)
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit balasan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BalasanEditPage(
                    balasan: balasan,
                  ),
                ),
              );
              _loadBalasanList();
            },
          ),
        if (isBalasanUser)
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: RPColors.merahMuda,
            ),
            title: const Text(
              'Hapus balasan',
              style: TextStyle(
                color: RPColors.merahMuda,
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              String message;
              try {
                await balasanService.deleteBalasan(balasan);
                message = 'Balasan berhasil dihapus.';
                _loadBalasanList();
              } catch (e) {
                message = e.toString();
              }

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            },
          ),
      ],
    ).show();
  }
}
