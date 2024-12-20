import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/services/restoran_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_menu_card_skeleton.dart';
import 'package:rasapalembang/widget/rp_minuman_card.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    final MinumanService minumanService = MinumanService();
    final RestoranService restoranService = RestoranService();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 100,
                    left: 16,
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            RPUrls.noProfileUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat datang,',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Guest',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 165,
                    left: 16,
                    right: 16,
                    child: RPTextFormField(
                      hintText: 'Cari',
                      prefixIcon: Icons.search,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 38.0),
            FutureBuilder(
              future: restoranService.get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildRecomendationList(
                    title: 'Top Restoran',
                    itemCount: 3,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada minuman"));
                } else {
                  return _buildRecomendationList(
                      title: 'Top Restoran',
                      type: 'restoran',
                      itemCount: 6,
                      data: snapshot.data
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            FutureBuilder(
              future: minumanService.get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildRecomendationList(
                    title: 'Top Minuman',
                    itemCount: 3,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada minuman"));
                } else {
                  return _buildRecomendationList(
                      title: 'Top Minuman',
                      type: 'minuman',
                      itemCount: 6,
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

  Widget _buildRecomendationList({
    required String title,
    required int itemCount,
    List? data,
    String? type,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(itemCount, (index) {
              final EdgeInsets padding = EdgeInsets.only(
                left: index == 0 ? 16.0 : 4.0,
                right: index == itemCount - 1 ? 16.0 : 4.0,
              );

              Widget item;
              if (type == 'minuman') {
                final minuman = data![index];
                item = RPMinumanCard(minuman: minuman);
              } else if (type == 'makanan') {
                item = RPMenuCardSkeleton();
              } else if (type == 'restoran') {
                item = RPMenuCardSkeleton();
              } else {
                item = RPMenuCardSkeleton();
              }

              return Padding(
                padding: padding,
                child: SizedBox(
                  width: 200,
                  child: item,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
