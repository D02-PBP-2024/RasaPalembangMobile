import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/screens/authentication/profile_edit.dart';
import 'package:rasapalembang/screens/restoran/restoran_form.dart';
import 'package:rasapalembang/services/restoran_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_bottom_navbar.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';
import 'package:rasapalembang/widget/rp_menu_card_skeleton.dart';
import 'package:rasapalembang/widget/rp_menu_grid_view.dart';
import 'package:rasapalembang/widget/rp_restoran_card.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String nama;
  final String deskripsi;
  final String peran;
  final String foto;
  final int poin;
  final DateTime dateJoined;
  final String? loggedInUsername;

  const ProfilePage({
    super.key,
    required this.username,
    required this.nama,
    required this.deskripsi,
    required this.peran,
    required this.foto,
    required this.poin,
    required this.dateJoined,
    required this.loggedInUsername,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  RestoranService restoranService = RestoranService();
  late String nama;
  late String deskripsi;
  late String foto;
  late Future<List<Restoran>> _restoranList;

  @override
  void initState() {
    super.initState();
    nama = widget.nama;
    deskripsi = widget.deskripsi;
    foto = widget.foto;
    if (widget.peran == 'pemilik_restoran') {
      _restoranList = restoranService.getByUsername(widget.username);
    }
  }

  void updateUser(String nama, String deskripsi, String foto) {
    setState(() {
      this.nama = nama;
      this.deskripsi = deskripsi;
      this.foto = foto;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    bool isLoggedInUser = widget.loggedInUsername == widget.username;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        actions: [
          if (isLoggedInUser)
            Tooltip(
              message: 'More',
              child: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onPressed: () {
                  _showProfileOption(request);
                },
              ),
            ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 150,
                    left: 16,
                    child: ClipOval(
                      child: Image.network(
                        foto != ''
                            ? RPUrls.baseUrl + foto
                            : RPUrls.noProfileUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 56.0),
                      Text(
                        nama,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '@${widget.username}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        deskripsi == '' ? 'Belum ada bio.' : deskripsi,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.person_outline, color: Colors.grey[600]),
                          const SizedBox(width: 4.0),
                          Text(
                            widget.peran == 'pengulas'
                                ? 'Pengulas'
                                : 'Pemilik Restoran',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.grey[600]),
                          const SizedBox(width: 4.0),
                          Text(
                            'Bergabung ${_formatDate(widget.dateJoined)}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.monetization_on, color: Colors.grey[600]),
                          const SizedBox(width: 4.0),
                          Text(
                            '${widget.poin} Poin',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.peran == 'pemilik_restoran')
                  Column(
                    children: [
                      FutureBuilder(
                        future: _restoranList,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return _buildRestoranGrid(
                                itemCount: 2, isLoading: true);
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text("Error: ${snapshot.error}"));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const SizedBox();
                          } else {
                            return _buildRestoranGrid(
                              itemCount: snapshot.data.length,
                              isLoading: false,
                              data: snapshot.data,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 72.0),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: widget.peran == 'pemilik_restoran' && isLoggedInUser
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestoranFormPage(),
                  ),
                );
              },
              child: Icon(Icons.storefront),
            )
          : null,
    );
  }

  Widget _buildRestoranGrid({
    required int itemCount,
    bool isLoading = false,
    List? data,
  }) {
    return RPMenuGridView(
      paddingTop: 24,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (isLoading) {
          return RPMenuCardSkeleton();
        } else {
          final restoran = data![index];
          return RPRestoCard(restoran: restoran);
        }
      },
    );
  }

  void _showProfileOption(request) {
    RPBottomSheet(
      context: context,
      widgets: [
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Edit profile'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileEditPage(
                  onChanged: updateUser,
                  nama: nama,
                  deskripsi: deskripsi,
                  foto: foto,
                ),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: RPColors.merahMuda,
          ),
          title: Text(
            'Logout',
            style: TextStyle(
              color: RPColors.merahMuda,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            _logout(request);
          },
        ),
      ],
    ).show();
  }

  void _logout(request) async {
    String message;
    try {
      final response = await request.logout();
      message = 'Sampai jumpa ${response?.username}!';
    } catch (e) {
      message = printException(e as Exception);
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RPBottomNavbar()),
      );
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMM y', 'id_ID').format(date);
  }
}
