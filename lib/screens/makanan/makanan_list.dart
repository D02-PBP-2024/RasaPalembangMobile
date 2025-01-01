import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/widget/rp_makanan_card.dart';
import 'package:rasapalembang/widget/rp_menu_card_skeleton.dart';
import 'package:rasapalembang/widget/rp_menu_grid_view.dart';
import 'package:rasapalembang/widget/rp_refresh_indicator.dart';

class MakananListPage extends StatefulWidget {
  const MakananListPage({super.key});

  @override
  State<MakananListPage> createState() => _MakananListPageState();
}

class _MakananListPageState extends State<MakananListPage> {
  MakananService makananService = MakananService();
  late Future<List<Makanan>> _makananList;

  @override
  void initState() {
    super.initState();
    _makananList = makananService.get();
  }

  Future<void> _refresh() async {
    setState(() {
      _makananList = makananService.get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RPRefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          children: [
            FutureBuilder(
              future: _makananList,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildMakananGrid(itemCount: 6, isLoading: true);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Belum ada makanan'));
                } else {
                  return _buildMakananGrid(
                      itemCount: snapshot.data.length,
                      isLoading: false,
                      data: snapshot.data
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMakananGrid(
      {required int itemCount, bool isLoading = false, List? data}) {
    return RPMenuGridView(
      paddingTop: 24,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (isLoading) {
          return RPMenuCardSkeleton();
        } else {
          final makanan = data![index];
          return RPMakananCard(makanan: makanan);
        }
      },
    );
  }
}
