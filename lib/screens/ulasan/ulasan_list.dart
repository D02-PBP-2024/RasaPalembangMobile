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
        return ulasanList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    bool ulasanUser = false;

    // cek apakah username user ada di dalam list ulasan
    if (request.loggedIn) {
      _ulasanFuture.then((ulasanList) {
        ulasanList.forEach((ulasan) {
          if (ulasan.user.username == request.user?.username) {
            ulasanUser = true;
          }
        });
      });
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder<List<Ulasan>>(
          future: _ulasanFuture,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildUlasanList(
                itemCount: 4,
                isLoading: true,
                request: request,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Belum ada diskusi."));
            } else {
              return _buildUlasanList(
                itemCount: snapshot.data.length,
                isLoading: false,
                data: snapshot.data,
                request: request,
              );
            }
          },
        ),
      ),
      floatingActionButton:
          request.user?.peran != 'pemilik_restoran' && ulasanUser
              ? RPFloatingButton(
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
                  icon: const Icon(Icons.add_reaction, color: Colors.white),
                  tooltip: 'Tambah Ulasan',
                )
              : null,
    );
  }

  Widget _buildUlasanList(
      {required int itemCount,
      bool isLoading = false,
      List? data,
      required UserService request}) {
    return RPListView(
        paddingBottom: request.user?.peran != 'pemilik_restoran' ? 80.0 : 8.0,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (isLoading) {
            return Column(
              children: [
                RPUlasanCardSkeleton(),
                if (index < itemCount - 1) SizedBox(height: 8.0),
              ],
            );
          } else {
            final ulasan = data![index];
            return Column(
              children: [
                RPUlasanCard(
                  ulasan: ulasan,
                  refreshList: _loadUlasanList,
                ),
                if (index < itemCount - 1) SizedBox(height: 8.0),
              ],
            );
          }
        });
  }
}
