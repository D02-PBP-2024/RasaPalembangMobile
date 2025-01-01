import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/ulasan.dart';
import 'package:rasapalembang/screens/authentication/show_login_bottom.dart';
import 'package:rasapalembang/screens/ulasan/ulasan_tambah.dart';
import 'package:rasapalembang/services/ulasan_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/widget/rp_floatingbutton.dart';
import 'package:rasapalembang/widget/rp_list_view.dart';
import 'package:rasapalembang/widget/rp_ulasan_card.dart';
import 'package:rasapalembang/widget/rp_ulasan_card_skeleton.dart';

class UlasanListPage extends StatefulWidget {
  final String idRestoran;

  const UlasanListPage({super.key, required this.idRestoran});

  @override
  State<UlasanListPage> createState() => _UlasanListPageState();
}

class _UlasanListPageState extends State<UlasanListPage> {
  late Future<List<Ulasan>> _ulasanFuture;
  late UlasanService ulasanService;
  bool isUserInList = false;

  @override
  void initState() {
    super.initState();
    ulasanService = UlasanService();
    _loadUlasanList();
  }

  void _loadUlasanList() {
    setState(() {
      _ulasanFuture = ulasanService.get(widget.idRestoran).then((ulasanList) {
        ulasanList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        isUserInList = ulasanList.any((ulasan) => ulasan.user.username == context.read<UserService>().user?.username);
        return ulasanList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder<List<Ulasan>>(
          future: _ulasanFuture,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildUlasanList(
                itemCount: 4,
                isLoading: true,
                request: request,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Stack(
                children: [
                  Center(child: Text("Belum ada ulasan.")),
                  if (!isUserInList && request.user?.peran != 'pemilik_restoran')
                    Positioned(
                      bottom: 16.0,
                      right: 16.0,
                      child: RPFloatingButton(
                        onPressed: () async {
                          if (request.loggedIn) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UlasanTambahPage(
                                  restoran: widget.idRestoran,
                                ),
                              ),
                            );
                            _loadUlasanList();
                          } else {
                            showLoginBottom(context);
                          }
                        },
                        icon:
                            const Icon(Icons.add_reaction, color: Colors.white),
                        tooltip: 'Tambah Ulasan',
                      ),
                    ),
                ],
              );
            } else {
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: buildUlasanList(
                          itemCount: snapshot.data.length,
                          isLoading: false,
                          data: snapshot.data,
                          request: request,
                        ),
                      ),
                    ],
                  ),
                  if (!isUserInList && request.user?.peran != 'pemilik_restoran')
                    Positioned(
                      bottom: 16.0,
                      right: 8.0,
                      child: RPFloatingButton(
                        onPressed: () async {
                          if (request.loggedIn) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UlasanTambahPage(
                                  restoran: widget.idRestoran,
                                ),
                              ),
                            );
                            _loadUlasanList();
                          } else {
                            showLoginBottom(context);
                          }
                        },
                        icon:
                            const Icon(Icons.add_reaction, color: Colors.white),
                        tooltip: 'Tambah Ulasan',
                      ),
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildUlasanList({
    required bool isLoading,
    required int itemCount,
    List? data,
    required UserService request,
  }) {
    return RPListView(
      paddingBottom: request.user?.peran != 'pemilik_restoran' && !isUserInList ? 80.0 : 8.0,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (isLoading) {
          return RPUlasanCardSkeleton();
        } else {
          return RPUlasanCard(
            ulasan: data![index],
            refreshList: _loadUlasanList,
          );
        }
      },
    );
  }
}
