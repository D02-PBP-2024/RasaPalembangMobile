import 'package:flutter/material.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/services/restoran_service.dart';
import 'package:http/http.dart' as http;
import 'package:rasapalembang/widget/rp_restoran_detail.dart';
import 'package:rasapalembang/screens/restoran/restoran_form.dart';
import 'package:rasapalembang/widget/rp_restoran_card.dart';
import 'dart:convert';
import 'package:rasapalembang/utils/urls_constants.dart';

class RestoranListPage extends StatefulWidget {
  const RestoranListPage({super.key});

  @override
  State<RestoranListPage> createState() => _RestoranListPageState();
}

class _RestoranListPageState extends State<RestoranListPage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    RestoranService().fetchUserData().then((data) {
      setState(() {
        userData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    RestoranService restoranService = RestoranService();
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (userData != null && userData?['peran'] == "pemilik_restoran")
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  final newRestoranData = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RestoranFormPage(),
                    ),
                  );

                  if (newRestoranData != null) {
                    setState(() {});
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF54BAB9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Tambah Restoran'),
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
      body: FutureBuilder(
        future: restoranService.get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada restoran."));
          } else {
            final restoranList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: restoranList.length,
                itemBuilder: (context, index) {
                  final restoran = restoranList[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RPRestoDetail(
                            restoran: restoran,
                          ),
                        ),
                      );
                    },
                    child: RPRestoCard(
                      nama: restoran.nama,
                      gambar: restoran.gambar,
                      rating: '4.5',
                      jamBuka: restoran.jamBuka,
                      jamTutup: restoran.jamTutup,
                      isOpen: _isCurrentlyOpen(
                        restoran.jamBuka,
                        restoran.jamTutup,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  bool _isCurrentlyOpen(String jamBuka, String jamTutup) {
    final now = TimeOfDay.now();
    final buka = _timeOfDayFromString(jamBuka);
    final tutup = _timeOfDayFromString(jamTutup);

    if (buka == null || tutup == null) return false;

    final nowMinutes = now.hour * 60 + now.minute;
    final bukaMinutes = buka.hour * 60 + buka.minute;
    final tutupMinutes = tutup.hour * 60 + tutup.minute;

    if (bukaMinutes <= tutupMinutes) {
      return nowMinutes >= bukaMinutes && nowMinutes <= tutupMinutes;
    } else {
      return nowMinutes >= bukaMinutes || nowMinutes <= tutupMinutes;
    }
  }

  TimeOfDay? _timeOfDayFromString(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return null;
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
