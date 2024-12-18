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
      nama: minuman.fields.nama,
      deskripsi: minuman.fields.deskripsi,
      gambar: minuman.fields.gambar,
      harga: minuman.fields.harga,
      ukuran: _title(minuman.fields.ukuran),
      tingkatKemanisan: minuman.fields.tingkatKemanisan,
      namaRestoran: minuman.fields.restoran.fields.nama,
      alamatRestoran: minuman.fields.restoran.fields.alamat,
      nomorTeleponRestoran: minuman.fields.restoran.fields.nomorTelepon,
      jamBukaRestoran: minuman.fields.restoran.fields.jamBuka,
      jamTutupRestoran: minuman.fields.restoran.fields.jamTutup,
    );
  }

  String _title(String string) {
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }
}