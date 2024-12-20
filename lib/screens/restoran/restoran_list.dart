import 'package:flutter/material.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/services/restoran_service.dart';
import 'package:rasapalembang/widget/rp_menu_card_skeleton.dart';
import 'package:rasapalembang/widget/rp_menu_grid_view.dart';
import 'package:rasapalembang/widget/rp_restoran_card.dart';

class RestoranListPage extends StatefulWidget {
  const RestoranListPage({super.key});

  @override
  State<RestoranListPage> createState() => _RestoranListPageState();
}

class _RestoranListPageState extends State<RestoranListPage> {
  RestoranService restoranService = RestoranService();
  late Future<List<Restoran>> _restoranList;

  @override
  void initState() {
    super.initState();
    _restoranList = restoranService.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                data: snapshot.data
            );
          }
        }
      ),
    );
  }

  Widget _buildRestoranGrid({required int itemCount, bool isLoading = false, List? data}) {
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
}
