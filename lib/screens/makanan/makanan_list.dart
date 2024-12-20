import 'package:flutter/material.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/widget/rp_makanan_card.dart';
import 'package:rasapalembang/widget/rp_menu_card_skeleton.dart';

class MakananListPage extends StatelessWidget {
  MakananListPage({super.key});

  @override
  Widget build(BuildContext context) {
    MakananService makanan = MakananService();
    return Scaffold(
      body: FutureBuilder(
        future: makanan.get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildMakananGrid(itemCount: 6, isLoading: true);
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada makanan"));
          } else {
            return _buildMakananGrid(
                itemCount: snapshot.data.length,
                isLoading: false,
                data: snapshot.data
            );
          }
        },
      ),
    );
  }

  Widget _buildMakananGrid({required int itemCount, bool isLoading = false, List? data}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.65,
              ),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (isLoading) {
                  return RPMenuCardSkeleton();
                } else {
                  final makanan = data![index];
                  return RPMakananCard(makanan: makanan);
                }
              },
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
