import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String nama;
  final String? deskripsi;
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
    required this. dateJoined,
    this.loggedInUsername,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
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
                        widget.foto,
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
                    widget.nama,
                    style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '@${widget.username}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.deskripsi ?? 'Belum ada bio.',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16.0),
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
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMM y', 'id_ID').format(date);
  }
}
