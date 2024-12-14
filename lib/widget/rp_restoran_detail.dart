import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Tambahkan ini
import 'package:rasapalembang/models/restoran.dart';
import 'dart:io';

class RPRestoDetail extends StatefulWidget {
  final Restoran restoran;

  const RPRestoDetail({super.key, required this.restoran});

  @override
  _RPRestoDetailState createState() => _RPRestoDetailState();
}

class _RPRestoDetailState extends State<RPRestoDetail> {
  LatLng? restoranLocation; // Lokasi koordinat restoran
  bool isLoading = true; // Status untuk proses loading

  @override
  void initState() {
    super.initState();
    _getCoordinatesFromAddress(widget.restoran.fields.alamat);
  }

  // Fungsi untuk mendapatkan koordinat dari alamat
  Future<void> _getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address); // Geocoding alamat
      if (locations.isNotEmpty) {
        setState(() {
          restoranLocation = LatLng(locations.first.latitude, locations.first.longitude);
          isLoading = false; // Selesai loading
        });
      }
    } catch (e) {
      // Jika gagal mendapatkan koordinat
      debugPrint('Gagal mendapatkan koordinat: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fields = widget.restoran.fields;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restoran'),
        backgroundColor: const Color(0xFF54BAB9),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Restoran
            Stack(
              children: [
                Image.file(
                  File(fields.gambar),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  child: Text(
                    fields.nama,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 6.0,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Informasi Restoran
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Alamat
                  Text(
                    fields.alamat,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // Nomor Telepon
                  Text(
                    fields.nomorTelepon,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // Jam Operasional
                  Row(
                    children: [
                      Text(
                        '${fields.jamBuka} - ${fields.jamTutup}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        _isCurrentlyOpen(fields.jamBuka, fields.jamTutup) ? 'Buka' : 'Tutup',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: _isCurrentlyOpen(fields.jamBuka, fields.jamTutup)
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Lokasi
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Lokasi',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator()) // Loading
                  : restoranLocation == null
                  ? const Center(
                child: Text(
                  'Lokasi tidak ditemukan',
                  style: TextStyle(fontSize: 16.0, color: Colors.red),
                ),
              ) // Jika lokasi tidak ditemukan
                  : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: restoranLocation!,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('restoran_marker'),
                    position: restoranLocation!,
                    infoWindow: InfoWindow(title: fields.nama),
                  ),
                },
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menentukan apakah restoran buka berdasarkan jam operasional
  bool _isCurrentlyOpen(String jamBuka, String jamTutup) {
    try {
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
    } catch (e) {
      return false;
    }
  }

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
