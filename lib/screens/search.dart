import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/services/restoran_service.dart';
import 'package:rasapalembang/widget/rp_horizontal_list_all.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class SearchPage extends StatefulWidget {
  final TextEditingController keywordController;

  const SearchPage({
    super.key,
    required this.keywordController,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final RestoranService restoranService = RestoranService();
  final MakananService makananService = MakananService();
  final MinumanService minumanService = MinumanService();
  late Future<List<Restoran>> _restoranList;
  late Future<List<Makanan>> _makananList;
  late Future<List<Minuman>> _minumanList;

  @override
  void initState() {
    super.initState();
    _searchKeyword();
  }

  void _searchKeyword() {
    if (widget.keywordController.text.isNotEmpty) {
      setState(() {
        _restoranList = restoranService.getKeyword(widget.keywordController.text);
        _makananList = makananService.getKeyword(widget.keywordController.text);
        _minumanList = minumanService.getKeyword(widget.keywordController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 72,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Row(
          children: [
            Expanded(
              child: RPTextFormField(
                hintText: 'Cari',
                controller: widget.keywordController,
                prefixIcon: Icons.search,
                iconOnPressed: _searchKeyword,
              ),
            ),
            const SizedBox(width: 16.0),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _restoranList,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return RPHorizontalListAll(
                    title: 'Restoran',
                    itemCount: 3,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SizedBox();
                } else {
                  return RPHorizontalListAll(
                      title: 'Restoran',
                      type: 'restoran',
                      itemCount: snapshot.data.length,
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
                    title: 'Makanan',
                    itemCount: 3,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SizedBox();
                } else {
                  return RPHorizontalListAll(
                      title: 'Makanan',
                      type: 'makanan',
                      itemCount: snapshot.data.length,
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
                    title: 'Minuman',
                    itemCount: 3,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SizedBox();
                } else {
                  return RPHorizontalListAll(
                      title: 'Minuman',
                      type: 'minuman',
                      itemCount: snapshot.data.length,
                      data: snapshot.data
                  );
                }
              },
            ),
            _buildNoDataMessage(),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataMessage() {
    return FutureBuilder(
      future: Future.wait([_restoranList, _makananList, _minumanList]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          bool allEmpty = snapshot.data!.every((data) => (data as List).isEmpty);
          if (allEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Center(child: Text("Tidak ada data yang ditemukan"))
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
