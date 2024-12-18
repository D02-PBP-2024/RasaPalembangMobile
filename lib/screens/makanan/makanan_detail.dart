import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/widget/rp_makanan_detail.dart';

class MakananDetailPage extends StatelessWidget {
  final Makanan makanan;

  const MakananDetailPage({
    super.key,
    required this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    return RPMakananDetail(
      nama: makanan.fields.nama,
      deskripsi: makanan.fields.deskripsi,
      gambar: makanan.fields.gambar,
      harga: makanan.fields.harga,
      kategori: _formatKategori(makanan.fields.kategori),
      kalori: makanan.fields.kalori,
      namaRestoran: 'namaRestoran',
      alamatRestoran: 'alamatRestoran',
      nomorTeleponRestoran: 'nomorTeleponRestoran',
      jamBukaRestoran: '10:00',
      jamTutupRestoran: '22:00',
    );
  }

  // Format list kategori menjadi string terpisah dengan koma
  String _formatKategori(List<String> kategoriList) {
    if (kategoriList.isEmpty) {
      return "Tidak ada kategori";
    }
    return kategoriList
        .map((kategori) =>
            "${kategori[0].toUpperCase()}${kategori.substring(1).toLowerCase()}")
        .join(", ");
  }
}