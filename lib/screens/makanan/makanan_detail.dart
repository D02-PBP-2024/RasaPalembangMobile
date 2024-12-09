import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/widget/rp_menu_detail.dart';

class MakananDetailPage extends StatelessWidget {
  final Makanan makanan;

  const MakananDetailPage({
    super.key,
    required this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    return RPMenuDetail(
      nama: makanan.fields.nama,
      deskripsi: makanan.fields.deskripsi,
      gambar: makanan.fields.gambar,
      harga: makanan.fields.harga,
      ukuran: "BESAR",
      tingkatKemanisan: 1000,
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