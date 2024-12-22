import 'package:flutter/material.dart';
import 'package:rasapalembang/models/favorit.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/screens/favorit/favorit_edit_dialog.dart';
import 'package:rasapalembang/services/favorit_service.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/services/restoran_service.dart';
import 'package:rasapalembang/widget/rp_favorit_card.dart';
import 'package:rasapalembang/widget/rp_minuman_detail.dart';

import '../../widget/restoran_detail.dart';
import '../../widget/rp_bottom_sheet.dart';
import '../../widget/rp_makanan_detail.dart';
import 'package:rasapalembang/widget/rp_minuman_detail.dart';

class FavoritListPage extends StatefulWidget {
  const FavoritListPage({
    super.key,
  });

  @override
  State<FavoritListPage> createState() => _FavoritListPageState();
}

class _FavoritListPageState extends State<FavoritListPage> {
  final FavoritService favoritService = FavoritService();
  List<Favorit> favoritList = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Favorit'),
      ),
      body: FutureBuilder(
        future: favoritService.get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada favorit yang ditambahkan."));
          } else {
            favoritList = snapshot.data;
              return ListView.builder(
                itemCount: favoritList.length,
                itemBuilder: (context, index) {
                  return RPFavoritCard(
                    favorit: favoritList[index],
                    delete: () async {
                      bool isDeleted = await
                        favoritService.delete(favoritList[index].pk);
                      if (isDeleted) setState(() {});
                    },
                    edit: () async {
                      String? catatan = await showDialog<String>(
                        context: context,
                        builder: (context) {
                          return FavoritEditDialog(
                            catatan: favoritList[index].fields.catatan,
                          );
                        },
                      );
                      if (catatan != null) {
                        // Use the 'catatan' value here
                        bool isSuccess = await 
                          favoritService.edit(favoritList[index].pk, catatan);
                        if (isSuccess) setState(() {});
                      }
                    },
                    onTap: () async {
                      Favorit favorit = favoritList[index];
                      if (favorit.fields.restoran != null) {
                        try {
                          // Fetch the list of restaurants
                          List<Restoran> restoranList = await RestoranService().get();

                          // Find the specific restaurant by pk
                          Restoran restoran = restoranList.firstWhere(
                            (restoran) => restoran.pk == favorit.fields.restoran!.pk,
                            orElse: () => throw Exception('Restoran not found'),
                          );

                          // Navigate to RestoranDetail and wait for the result
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestoranDetail(restoran: restoran),
                            ),
                          );

                          // Update state after navigation
                          setState(() {});
                        } catch (e) {
                          // Handle errors, e.g., show a snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      } else if (favorit.fields.minuman != null) {
                        try {
                          // Fetch the list of drinks
                          List<Minuman> minumanList = await MinumanService().get();

                          // Find the specific drink by pk
                          Minuman minuman = minumanList.firstWhere(
                            (minuman) => minuman.pk == favorit.fields.minuman!.pk,
                            orElse: () => throw Exception('Minuman not found'),
                          );

                          // Show the bottom sheet and wait for it to close
                          await RPBottomSheet(
                            context: context,
                            widgets: [
                              RPMinumanDetail(minuman: minuman)
                            ],
                          ).show();

                          // Update state after the bottom sheet is closed
                          setState(() {});
                        } catch (e) {
                          // Handle errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      } else if (favorit.fields.makanan != null) {
                        try {
                          // Fetch the list of foods
                          List<Makanan> makananList = await MakananService().get();

                          // Find the specific food by pk
                          Makanan makanan = makananList.firstWhere(
                            (makanan) => makanan.pk == favorit.fields.makanan!.pk,
                            orElse: () => throw Exception('Makanan not found'),
                          );

                          // Show the bottom sheet and wait for it to close
                          await RPBottomSheet(
                            context: context,
                            widgets: [
                              RPMakananDetail(makanan: makanan),
                            ],
                          ).show();

                          // Update state after the bottom sheet is closed
                          setState(() {});
                        } catch (e) {
                          // Handle errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      }
                    },
                  );
                },
              );
          }
        },
      )
    );
  }
}
