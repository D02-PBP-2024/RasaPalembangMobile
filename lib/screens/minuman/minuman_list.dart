import 'package:flutter/material.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/widget/rp_menu_card_skeleton.dart';
import 'package:rasapalembang/widget/rp_minuman_card.dart';

class MinumanListPage extends StatefulWidget {
  MinumanListPage({super.key});

  @override
  _MinumanListPageState createState() => _MinumanListPageState();
}

class _MinumanListPageState extends State<MinumanListPage> {
  
  @override
  Widget build(BuildContext context) {
    MinumanService minuman = MinumanService();
    return Scaffold(
      body: FutureBuilder(
        future: minuman.get(),
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
    );
  }

  Widget _buildMinumanGrid({required int itemCount, bool isLoading = false, List? data}) {
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
                  final minuman = data![index];
                  return RPMinumanCard(minuman: minuman);
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
