import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/screens/favorit/route.dart';
import 'package:rasapalembang/screens/search.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/services/restoran_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_horizontal_list_all.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _keywordController = TextEditingController();

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    final RestoranService restoranService = RestoranService();
    final MakananService makananService = MakananService();
    final MinumanService minumanService = MinumanService();
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
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 16,
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            request.loggedIn
                                ? request.user!.foto != ''
                                  ? RPUrls.baseUrl + request.user!.foto
                                  : RPUrls.noProfileUrl
                                : RPUrls.noProfileUrl,
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
                              'Selamat datang',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            if (request.loggedIn)
                              Text(
                                request.user!.nama,
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
                  if (request.loggedIn)
                    Positioned(
                      top: 120,
                      right: 40,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) => FavoritRoute()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            'Favorit',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ),
                  Positioned(
                    top: 165,
                    left: 16,
                    right: 16,
                    child: RPTextFormField(
                      hintText: 'Cari',
                      controller: _keywordController,
                      prefixIcon: Icons.search,
                      iconOnPressed: () {
                        if (_keywordController.text.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(
                                keywordController: _keywordController,
                              ),
                            ),
                          );
                        }
                      },
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
                  return RPHorizontalListAll(
                    title: 'Top Restoran',
                    itemCount: 3,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada minuman"));
                } else {
                  return RPHorizontalListAll(
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
              future: makananService.get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return RPHorizontalListAll(
                    title: 'Top Makanan',
                    itemCount: 3,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada minuman"));
                } else {
                  return RPHorizontalListAll(
                    title: 'Top Makanan',
                    type: 'makanan',
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
                  return RPHorizontalListAll(
                    title: 'Top Minuman',
                    itemCount: 3,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada minuman"));
                } else {
                  return RPHorizontalListAll(
                    title: 'Top Minuman',
                    type: 'minuman',
                    itemCount: 6,
                    data: snapshot.data
                  );
                }
              },
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}