import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/screens/authentication/show_login_bottom.dart';
import 'package:rasapalembang/screens/forum/forum_list.dart';
import 'package:rasapalembang/screens/makanan/makanan_tambah.dart';
import 'package:rasapalembang/screens/minuman/minuman_tambah.dart';
import 'package:rasapalembang/screens/restoran/restoran_edit_form.dart';
import 'package:rasapalembang/screens/ulasan/ulasan_list.dart';
import 'package:rasapalembang/services/favorit_service.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/services/restoran_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/is_open.dart';
import 'package:rasapalembang/utils/rp_cache.dart';
import 'package:rasapalembang/utils/size_constants.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';
import 'package:rasapalembang/widget/rp_image_error.dart';
import 'package:rasapalembang/widget/rp_image_loading.dart';
import 'package:rasapalembang/widget/rp_makanan_card.dart';
import 'package:rasapalembang/widget/rp_menu_card_skeleton.dart';
import 'package:rasapalembang/widget/rp_menu_grid_view.dart';
import 'package:rasapalembang/widget/rp_minuman_card.dart';

class RestoranDetail extends StatefulWidget {
  final Restoran restoran;

  const RestoranDetail({super.key, required this.restoran});

  @override
  State<RestoranDetail> createState() => _RestoranDetailState();
}

class _RestoranDetailState extends State<RestoranDetail> with SingleTickerProviderStateMixin {
  FavoritService favoritService = FavoritService();
  MakananService makananService = MakananService();
  MinumanService minumanService = MinumanService();
  late Future<List<Makanan>> _makananList;
  late Future<List<Minuman>> _minumanList;
  late TabController _tabController;
  LatLng? restoranLocation;
  bool isLoading = true;
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;
  final double _scrollThreshold = 340.0;
  late Widget _ulasanPage;
  late Widget _forumPage;
  late bool _favorited;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _getCoordinatesFromAddress(widget.restoran.alamat);
    _makananList = makananService.getByRestoran(widget.restoran.pk);
    _minumanList = minumanService.getByRestoran(widget.restoran.pk);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
    _ulasanPage = UlasanListPage(idRestoran: widget.restoran.pk);
    _forumPage = ForumListPage(idRestoran: widget.restoran.pk);
    _favorited = widget.restoran.favorit != null;
  }

  Future<void> _getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        setState(() {
          restoranLocation =
              LatLng(locations.first.latitude, locations.first.longitude);
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
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 500,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: RPUrls.baseUrl + widget.restoran.gambar,
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => RPImageLoading(),
                      errorWidget: (context, url, error) => RPImageError(),
                      cacheManager: RPCache.rpCacheManager,
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
                              widget.restoran.nama,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            RatingBar.builder(
                              initialRating: widget.restoran.rating?.toDouble() ?? 0.0,
                              itemSize: 24,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              unratedColor: Colors.grey,
                              itemCount: 5,
                              itemBuilder: (context, index) => Icon(
                                Icons.star_rounded,
                                color: index < (widget.restoran.rating ?? 0)
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                              onRatingUpdate: (rating) { },
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  isCurrentlyOpen(widget.restoran.jamBuka,
                                          widget.restoran.jamTutup)
                                      ? 'Buka'
                                      : 'Tutup',
                                  style: TextStyle(
                                    color: isCurrentlyOpen(
                                            widget.restoran.jamBuka,
                                            widget.restoran.jamTutup)
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  '${widget.restoran.jamBuka} - ${widget.restoran.jamTutup}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              widget.restoran.alamat,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              widget.restoran.nomorTelepon,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 32.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                labelColor: RPColors.biruMuda,
                unselectedLabelColor: Colors.grey,
                indicatorColor: RPColors.biruMuda,
                tabs: [
                  Tab(text: 'Makanan'),
                  Tab(text: 'Minuman'),
                  Tab(text: 'Ulasan'),
                  Tab(text: 'Forum'),
                ],
              ),
              actions: [
                IconButton(
                  icon: _favorited
                    ? Icon(
                      Icons.favorite_rounded,
                      color: RPColors.merahMuda,
                    )
                    : Icon(
                      Icons.favorite_outline_rounded,
                      color: _scrollOffset > _scrollThreshold
                          ? Colors.black
                          : Colors.white,
                      ),
                  onPressed: () async {
                    if (_favorited) {
                      await favoritService.delete(widget.restoran.favorit!);
                      setState(() {
                        _favorited = false;
                      });
                    } else {
                     if (request.loggedIn) {
                       await favoritService.add(null, null, widget.restoran);
                       setState(() {
                         _favorited = true;
                       });
                     } else {
                       showLoginBottom(context);
                     }
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: _scrollOffset > _scrollThreshold
                        ? Colors.black
                        : Colors.white,
                  ),
                  onPressed: () {
                    _showRestoranOption(request);
                  },
                ),
              ],
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: _scrollOffset > _scrollThreshold
                      ? Colors.black
                      : Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _makananTab(),
            _minumanTab(),
            _ulasanTab(),
            _forumTab(),
          ],
        ),
      ),
    );
  }

  void _showRestoranOption(request) {
    RPBottomSheet(
      context: context,
      widgets: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Lihat lokasi di peta'),
          onTap: () {
            Navigator.pop(context);
            _showLocation();
          },
        ),
        if (request.user?.username == widget.restoran.user)
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.rice_bowl),
                title: Text('Tambah makanan'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MakananTambahPage(
                        restoran: widget.restoran,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.wine_bar),
                title: Text('Tambah minuman'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MinumanTambahPage(
                        restoran: widget.restoran,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Edit restoran'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestoranEditForm(
                        restoran: widget.restoran,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: RPColors.merahMuda,
                ),
                title: Text(
                  'Hapus restoran',
                  style: TextStyle(
                    color: RPColors.merahMuda,
                  ),
                ),
                onTap: () async {
                  Navigator.pop(context); // Menutup modal dialog

                  try {
                    final bool? confirmDelete = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: const Text('Apakah Anda yakin ingin menghapus restoran ini?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Hapus'),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmDelete == true) {
                      final RestoranService restoranService = RestoranService();
                      final String message = await restoranService.delete(widget.restoran);

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                        Navigator.pop(context);
                      }
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Gagal menghapus restoran: $e')),
                      );
                    }
                  }
                },
              ),
            ],
          )
      ],
    ).show();
  }

  void _showLocation() {
    RPBottomSheet(
      context: context,
      widgets: [
        SizedBox(
          height: 500,
          child: Column(
            children: [
              if (!isLoading && restoranLocation != null)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(RPSize.cornerRadius),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: restoranLocation!,
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('restoran_marker'),
                            position: restoranLocation!,
                            infoWindow: InfoWindow(title: widget.restoran.nama),
                          ),
                        },
                      ),
                    ),
                  ),
                ),
              if (isLoading) const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
    ).show();
  }

  Widget _makananTab() {
    return FutureBuilder(
      future: _makananList,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildMenuGrid(itemCount: 6);
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Belum ada makanan"));
        } else {
          return _buildMenuGrid(
              itemCount: snapshot.data.length,
              type: 'makanan',
              data: snapshot.data);
        }
      },
    );
  }

  Widget _minumanTab() {
    return FutureBuilder(
      future: _minumanList,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildMenuGrid(itemCount: 6);
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Belum ada minuman"));
        } else {
          return _buildMenuGrid(
              itemCount: snapshot.data.length,
              type: 'minuman',
              data: snapshot.data);
        }
      },
    );
  }

  Widget _ulasanTab() {
    return _ulasanPage;
  }

  Widget _forumTab() {
    return _forumPage;
  }

  Widget _buildMenuGrid({required int itemCount, List? data, String? type}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: RPMenuGridView(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (type == 'makanan') {
            final makanan = data![index];
            return RPMakananCard(
              makanan: makanan,
              lihatRestoran: false,
            );
          } else if (type == 'minuman') {
            final minuman = data![index];
            return RPMinumanCard(
              minuman: minuman,
              lihatRestoran: false,
            );
          } else {
            return RPMenuCardSkeleton();
          }
        },
      ),
    );
  }
}
