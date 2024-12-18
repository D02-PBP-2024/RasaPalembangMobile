import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/screens/authentication/login.dart';
import 'package:rasapalembang/screens/authentication/profile_edit.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/widget/rp_button.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String nama;
  final String deskripsi;
  final String peran;
  final String foto;
  final int poin;
  final DateTime dateJoined;
  final String loggedInUsername;

  const ProfilePage({
    super.key,
    required this.username,
    required this.nama,
    required this.deskripsi,
    required this.peran,
    required this.foto,
    required this.poin,
    required this. dateJoined,
    required this.loggedInUsername,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String nama;
  late String deskripsi;
  late String foto;
  late int imageKey;

  @override
  void initState() {
    super.initState();
    nama = widget.nama;
    deskripsi = widget.deskripsi;
    foto = widget.foto;
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));

    final request = context.watch<UserService>();
    bool isLoggedInUser = widget.loggedInUsername == widget.username;

    return Scaffold(
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
                        foto,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 56.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '@${widget.username}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    deskripsi == "" ? 'Belum ada bio.' : deskripsi,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.person_outline, color: Colors.grey[600]),
                      const SizedBox(width: 4.0),
                      Text(
                        widget.peran == 'pengulas' ? 'Pengulas' : 'Pemilik Restoran',
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
                  if (isLoggedInUser)
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        RPButton(
                          label: 'Edit Profile',
                          onPressed: () {
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
                        const SizedBox(width: 8.0),
                        RPButton(
                          label: 'Logout',
                          onPressed: () async {
                            final response = await request.logout();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(response['message']),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              );
                            }
                          },
                        )
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMM y', 'id_ID').format(date);
  }
}
