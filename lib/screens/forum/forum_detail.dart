import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/models/balasan.dart';
import 'package:rasapalembang/screens/authentication/show_login_bottom.dart';
import 'package:rasapalembang/services/balasan_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/date_time_extension.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_balasan_card.dart';
import 'package:rasapalembang/widget/rp_balasan_card_skeleton.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

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
  final TextEditingController _editBalasanController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNodeEdit = FocusNode();
  bool _isTypingBalasan = false;
  bool _isEditBalasan = false;
  late Balasan? balasan;

  @override
  void initState() {
    super.initState();
    balasanService = BalasanService();
    loadBalasanList();
  }

  @override
  void dispose() {
    _balasanController.dispose();
    _editBalasanController.dispose();
    _focusNode.dispose();
    _focusNodeEdit.dispose();
    super.dispose();
  }

  void loadBalasanList() {
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

      if (mounted) {
        setState(() {
          _isTypingBalasan = false;
        });
      }

      loadBalasanList();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(printException(e as Exception))),
        );
      }
    }
  }

  void editBalasan(Balasan balasan) {
    _focusNodeEdit.requestFocus();
    setState(() {
      this.balasan = balasan;
      _isTypingBalasan = false;
      _isEditBalasan = true;
      _editBalasanController.text = balasan.pesan;
    });
  }

  void _cancelEditBalasan() {
    setState(() {
      balasan = null;
      _isEditBalasan = false;
      _editBalasanController.clear();
    });
  }

  void _sendEditBalasan() async {
    if (balasan != null) {
      if (_editBalasanController.text.trim().isEmpty) return;

      balasan?.pesan = _editBalasanController.text.trim();

      try {
        await balasanService.editBalasan(balasan!);
        _editBalasanController.clear();

        if (mounted) {
          setState(() {
            balasan = null;
            _isEditBalasan = false;
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(printException(e as Exception))),
          );
        }
      }
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
            return RPBalasanCardSkeleton();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final balasanList = snapshot.data ?? [];
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    widget.forum.user.foto != ''
                                        ? RPUrls.baseUrl + widget.forum.user.foto
                                        : RPUrls.noProfileUrl,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.forum.user.nama,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 2.0),
                                    Text(
                                      widget.forum.tanggalPosting.timeAgo(),
                                      style: TextStyle(
                                        color: RPColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              widget.forum.topik,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              widget.forum.pesan,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 8.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  if (request.loggedIn) {
                                    setState(() {
                                      _isTypingBalasan = true;
                                      _isEditBalasan = false;
                                    });
                                    _focusNode.requestFocus();
                                  } else {
                                    showLoginBottom(context);
                                  }
                                },
                                icon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.reply_rounded,
                                      color: RPColors.textSecondary,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      'Balas',
                                      style: TextStyle(
                                        color: RPColors.textSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            const SizedBox(height: 4.0),
                            Text(
                              '${balasanList.length} Balasan',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            if (balasanList.isEmpty)
                              const Center(child: Text("Belum ada balasan."))
                            else
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8.0),
                                  Column(
                                    children: balasanList.reversed.toList().asMap().entries.map((balasan) {
                                      return Column(
                                        children: [
                                          RPBalasanCard(
                                            balasan: balasan.value,
                                            refreshList: loadBalasanList,
                                            editBalasan: editBalasan,
                                          ),
                                          if (balasan.key < balasanList.length - 1) SizedBox(height: 8.0),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
                if (_isTypingBalasan)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RPTextFormField(
                            hintText: 'Ketik balasan...',
                            controller: _balasanController,
                            focusNode: _focusNode,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                              Icons.send_rounded,
                              color: RPColors.biruMuda
                          ),
                          onPressed: _sendBalasan,
                        ),
                      ],
                    ),
                  ),
                if (_isEditBalasan)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RPTextFormField(
                            prefixIcon: Icons.close,
                            iconOnPressed: _cancelEditBalasan,
                            hintText: 'Ketik balasan...',
                            controller: _editBalasanController,
                            focusNode: _focusNodeEdit,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                              Icons.send_rounded,
                              color: RPColors.biruMuda
                          ),
                          onPressed: _sendEditBalasan,
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
}
