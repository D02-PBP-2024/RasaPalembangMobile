import 'package:flutter/material.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/widget/rp_restoran_detail.dart';
import 'package:rasapalembang/screens/restoran/restoran_form.dart';
import 'package:rasapalembang/widget/rp_restoran_card.dart';

class RestoranListPage extends StatefulWidget {
  const RestoranListPage({super.key});

  @override
  State<RestoranListPage> createState() => _RestoranListPageState();
}

class _RestoranListPageState extends State<RestoranListPage> {
  final List<Restoran> restoranList = []; // Menggunakan model Restoran secara langsung

  // Menambahkan restoran baru ke dalam list
  void _addNewRestoran(Map<String, dynamic> newRestoranData) {
    setState(() {
      restoranList.add(Restoran.fromJson(newRestoranData));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Restoran'),
        actions: [
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
                  _addNewRestoran(newRestoranData);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF54BAB9), // Warna tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Tambah Restoran'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: restoranList.isEmpty
            ? const Center(
          child: Text(
            'Belum ada restoran yang ditambahkan',
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        )
            : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 kartu per baris
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.75, // Sesuaikan rasio kartu
          ),
          itemCount: restoranList.length,
          itemBuilder: (context, index) {
            final restoran = restoranList[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RPRestoDetail(restoran: restoran),
                  ),
                );
              },
              child: RPRestoCard(
                nama: restoran.nama,
                gambar: restoran.gambar,
                rating: '4.5', // placeholder
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
      ),
    );
  }

  // Fungsi untuk menentukan apakah restoran buka berdasarkan jam operasional (termasuk yang melewati tengah malam)
  bool _isCurrentlyOpen(String jamBuka, String jamTutup) {
    try {
      final now = TimeOfDay.now();
      final buka = _timeOfDayFromString(jamBuka);
      final tutup = _timeOfDayFromString(jamTutup);

      if (buka == null || tutup == null) return false;

      // Konversi TimeOfDay ke menit sejak tengah malam
      final nowMinutes = now.hour * 60 + now.minute;
      final bukaMinutes = buka.hour * 60 + buka.minute;
      final tutupMinutes = tutup.hour * 60 + tutup.minute;

      if (bukaMinutes < tutupMinutes) {
        // Restoran buka dan tutup di hari yang sama
        return bukaMinutes <= nowMinutes && nowMinutes <= tutupMinutes;
      } else {
        // Restoran buka melewati tengah malam
        return nowMinutes >= bukaMinutes || nowMinutes <= tutupMinutes;
      }
    } catch (e) {
      return false;
    }
  }

  // Fungsi untuk mengonversi string jam ke TimeOfDay
  TimeOfDay? _timeOfDayFromString(String time) {
    try {
      final parts = time.split(':');
      if (parts.length != 2) return null;
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (e) {
      return null;
    }
  }
}
