import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/format_harga.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/restoran_detail.dart';
import 'package:rasapalembang/widget/rp_button.dart';

class RPMakananDetail extends StatefulWidget {
  final Makanan makanan;
  final bool lihatRestoran;

  const RPMakananDetail({
    super.key,
    required this.makanan,
    this.lihatRestoran = true,
  });

  @override
  State<RPMakananDetail> createState() => _RPMakananDetailState();
}

class _RPMakananDetailState extends State<RPMakananDetail> {
  final MakananService makananService = MakananService();
  Map<String, String> kategoriMap = {};
  bool isLoadingKategori = true;

  @override
  void initState() {
    super.initState();
    _fetchKategori();
  }

  Future<void> _fetchKategori() async {
    try {
      final result = await makananService.fetchCategories();
      setState(() {
        kategoriMap = result; // Simpan map UUID -> Nama
        isLoadingKategori = false;
      });
    } catch (e) {
      setState(() {
        isLoadingKategori = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal memuat kategori: $e")),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    Makanan makanan = widget.makanan;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    '${RPUrls.baseUrl}${makanan.gambar}',
                    width: double.infinity,
                    height: screenWidth - 32,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      // TODO: menambah ke favorit
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              makanan.nama,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: RPColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              makanan.deskripsi,
              style: const TextStyle(
                fontSize: 18.0,
                color: RPColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FormatHarga.format(makanan.harga),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: RPColors.textPrimary,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 8.0),
                    _infoCard('${makanan.kalori} kkal', Icons.dining_outlined),
                  ],
                ),
              ],
            ),
            if (makanan.kategori.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12.0),
                  Text(
                    'Kategori',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: RPColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildCategoryCards(widget.makanan.kategori),
                ],
              ),
            if (widget.lihatRestoran)
              Column(
                children: [
                  const SizedBox(height: 20.0),
                  RPButton(
                    label: 'Lihat Restoran',
                    width: double.infinity,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestoranDetail(
                            restoran: widget.makanan.restoran,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String text, IconData icon) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18.0,
            ),
            const SizedBox(width: 4.0),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCards(List<String> kategori) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: kategori.map((kategoriId) {
        final kategoriNama = kategoriMap[kategoriId] ?? 'Tidak Diketahui';
        return _infoCard(kategoriNama, Icons.label_important_outline_rounded); // Gunakan _infoCard
      }).toList(),
    );
  }
}
