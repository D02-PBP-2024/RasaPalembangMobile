import 'package:flutter/material.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/services/restoran_service.dart';
import 'package:rasapalembang/widget/rp_menu_card_skeleton.dart';
import 'package:rasapalembang/widget/rp_menu_grid_view.dart';
import 'package:rasapalembang/widget/rp_restoran_card.dart';
import 'package:rasapalembang/screens/restoran/restoran_form.dart';

class RestoranListPage extends StatefulWidget {
  const RestoranListPage({super.key});

  @override
  State<RestoranListPage> createState() => _RestoranListPageState();
}

class _RestoranListPageState extends State<RestoranListPage> {
  RestoranService restoranService = RestoranService();
  late Future<List<Restoran>> _restoranList;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _restoranList = restoranService.get();
    restoranService.fetchUserData().then((data) {
      setState(() {
        userData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    setState(() {
                      _restoranList = restoranService.get();
                    });
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
        future: _restoranList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildRestoranGrid(itemCount: 6, isLoading: true);
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada restoran."));
          } else {
            return _buildRestoranGrid(
              itemCount: snapshot.data.length,
              isLoading: false,
              data: snapshot.data,
            );
          }
        },
      ),
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
