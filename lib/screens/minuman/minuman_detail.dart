import 'package:flutter/material.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/widget/rp_menu_detail.dart';

class MinumanDetailPage extends StatelessWidget {
  final Minuman minuman;

  const MinumanDetailPage({
    super.key,
    required this.minuman,
  });

  @override
  Widget build(BuildContext context) {
    return RPMenuDetail(
      nama: minuman.nama,
      deskripsi: minuman.deskripsi,
      gambar: minuman.gambar,
      harga: minuman.harga,
      ukuran: _title(minuman.ukuran),
      tingkatKemanisan: minuman.tingkatKemanisan,
      namaRestoran: minuman.restoran.nama,
      alamatRestoran: minuman.restoran.alamat,
      nomorTeleponRestoran: minuman.restoran.nomorTelepon,
      jamBukaRestoran: minuman.restoran.jamBuka,
      jamTutupRestoran: minuman.restoran.jamTutup,
    );
  }

  String _title(String string) {
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }
}