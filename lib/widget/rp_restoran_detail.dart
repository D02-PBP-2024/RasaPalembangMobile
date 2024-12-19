import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/screens/minuman/minuman_tambah.dart';
import 'package:rasapalembang/screens/restoran/restoran_edit_form.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_button.dart';


class RPRestoDetail extends StatefulWidget {
  final Restoran restoran;

  const RPRestoDetail({super.key, required this.restoran});

  @override
  _RPRestoDetailState createState() => _RPRestoDetailState();
}

class _RPRestoDetailState extends State<RPRestoDetail> {
  LatLng? restoranLocation;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCoordinatesFromAddress(widget.restoran.alamat);
  }

  Future<void> _getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        setState(() {
          restoranLocation = LatLng(locations.first.latitude, locations.first.longitude);
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Gagal mendapatkan koordinat: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final restoran = widget.restoran;
    final request = context.watch<UserService>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // Gambar Restoran dengan semua informasi
          Stack(
            children: [
              Image.network(
                RPUrls.baseUrl + restoran.gambar,
                width: double.infinity,
                height: 500,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black87, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restoran.nama,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text(
                            _isCurrentlyOpen(restoran.jamBuka, restoran.jamTutup)
                                ? 'Buka'
                                : 'Tutup',
                            style: TextStyle(
                              color: _isCurrentlyOpen(restoran.jamBuka, restoran.jamTutup)
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            '${restoran.jamBuka} - ${restoran.jamTutup}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        restoran.alamat,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        restoran.nomorTelepon,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Tombol Aksi dalam satu baris
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final updatedData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestoranEditForm(
                            restoran: {
                              'nama': restoran.nama,
                              'alamat': restoran.alamat,
                              'jamBuka': restoran.jamBuka,
                              'jamTutup': restoran.jamTutup,
                              'nomorTelepon': restoran.nomorTelepon,
                              'gambar': restoran.gambar,
                            },
                          ),
                        ),
                      );

                      if (updatedData != null) {
                        setState(() {
                          restoran.nama = updatedData['nama'];
                          restoran.alamat = updatedData['alamat'];
                          restoran.jamBuka = updatedData['jamBuka'];
                          restoran.jamTutup = updatedData['jamTutup'];
                          restoran.nomorTelepon = updatedData['nomorTelepon'];
                          restoran.gambar = updatedData['gambar'];
                        });
                        // Update koordinat berdasarkan alamat yang baru
                        setState(() {
                          isLoading = true; // Aktifkan loading sebelum mendapatkan koordinat baru
                        });
                        await _getCoordinatesFromAddress(updatedData['alamat']);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan[400],
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      'Ubah Restoran',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Aksi hapus restoran
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      'Hapus Restoran',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          RPButton(
            label: 'Forum Diskusi',
            onPressed: () {

            },
          ),

          if (request.user?.username == restoran.user)
            Column(
              children: [
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RPButton(
                      label: 'Tambah Makanan',
                      onPressed: () {

                      },
                    ),
                    const SizedBox(width: 8.0),
                    RPButton(
                      label: 'Tambah Minuman',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MinumanTambahPage(restoran: restoran),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),


          // Tambahkan judul lokasi
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Lokasi',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Lokasi Google Maps
          if (!isLoading && restoranLocation != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: restoranLocation!,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('restoran_marker'),
                      position: restoranLocation!,
                      infoWindow: InfoWindow(title: restoran.nama),
                    ),
                  },
                ),
              ),
            ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
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
