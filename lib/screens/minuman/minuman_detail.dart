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
      namaRestoran: 'namaRestoran',
      alamatRestoran: 'alamatRestoran',
      nomorTeleponRestoran: 'nomorTeleponRestoran',
      jamBukaRestoran: '10:00',
      jamTutupRestoran: '22:00'
    );
  }

  String _title(String string) {
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }
}