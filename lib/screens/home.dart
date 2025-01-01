import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/screens/search.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/services/restoran_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/rp_cache.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_horizontal_list_all.dart';
import 'package:rasapalembang/widget/rp_image_error.dart';
import 'package:rasapalembang/widget/rp_image_loading.dart';
import 'package:rasapalembang/widget/rp_refresh_indicator.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _keywordController = TextEditingController();
  final RestoranService restoranService = RestoranService();
  final MakananService makananService = MakananService();
  final MinumanService minumanService = MinumanService();
  late Future<List<Makanan>> _makananList;
  late Future<List<Minuman>> _minumanList;
  late Future<List<Restoran>> _restoranList;

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _makananList = makananService.getRandom(6);
    _minumanList = minumanService.getRandom(6);
    _restoranList = restoranService.getRandom(6);
  }

  Future<void> _refresh() async {
    setState(() {
      _makananList = makananService.getRandom(6);
      _minumanList = minumanService.getRandom(6);
      _restoranList = restoranService.getRandom(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    return Scaffold(
      body: RPRefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: EdgeInsets.zero,
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
                          child: CachedNetworkImage(
                            imageUrl: request.loggedIn
                                ? request.user!.foto != ''
                                ? RPUrls.baseUrl + request.user!.foto
                                : RPUrls.noProfileUrl
                                : RPUrls.noProfileUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => RPImageLoading(),
                            errorWidget: (context, url, error) => RPImageError(),
                            cacheManager: RPCache.rpCacheManager,
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
              future: _restoranList,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return RPHorizontalListAll(
                    title: 'Rekomendasi Restoran',
                    itemCount: 3,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada minuman"));
                } else {
                  return RPHorizontalListAll(
                      title: 'Rekomendasi Restoran',
                      type: 'restoran',
                      itemCount: min(6, snapshot.data.length),
                      data: snapshot.data
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            FutureBuilder(
              future: _makananList,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return RPHorizontalListAll(
                    title: 'Rekomendasi Makanan',
                    itemCount: 3,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada minuman"));
                } else {
                  return RPHorizontalListAll(
                      title: 'Rekomendasi Makanan',
                      type: 'makanan',
                      itemCount: min(6, snapshot.data.length),
                      data: snapshot.data
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            FutureBuilder(
              future: _minumanList,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return RPHorizontalListAll(
                    title: 'Rekomendasi Minuman',
                    itemCount: 3,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada minuman"));
                } else {
                  return RPHorizontalListAll(
                      title: 'Rekomendasi Minuman',
                      type: 'minuman',
                      itemCount: min(6, snapshot.data.length),
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
