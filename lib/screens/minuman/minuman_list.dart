import 'package:flutter/material.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/widget/rp_menu_card_skeleton.dart';
import 'package:rasapalembang/widget/rp_menu_grid_view.dart';
import 'package:rasapalembang/widget/rp_minuman_card.dart';
import 'package:rasapalembang/widget/rp_refresh_indicator.dart';

class MinumanListPage extends StatefulWidget {
  const MinumanListPage({super.key});

  @override
  State<MinumanListPage> createState() => _MinumanListPageState();
}

class _MinumanListPageState extends State<MinumanListPage> {
  MinumanService minumanService = MinumanService();
  late Future<List<Minuman>> _minumanList;

  @override
  void initState() {
    super.initState();
    _minumanList = minumanService.get();
  }

  Future<void> _refresh() async {
    setState(() {
      _minumanList = minumanService.get();
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
              future: _minumanList,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildMinumanGrid(itemCount: 6, isLoading: true);
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada minuman"));
                } else {
                  return _buildMinumanGrid(
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

  Widget _buildMinumanGrid(
      {required int itemCount, bool isLoading = false, List? data}) {
    return RPMenuGridView(
      paddingTop: 24,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (isLoading) {
          return RPMenuCardSkeleton();
        } else {
          final minuman = data![index];
          return RPMinumanCard(minuman: minuman);
        }
      },
    );
  }
}
