import 'package:flutter/material.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/widget/makanan_form.dart';

class MakananTambahPage extends StatelessWidget {
  final Restoran restoran;

  MakananTambahPage({
    super.key,
    required this.restoran
  });

  @override
  Widget build(BuildContext context) {
    MakananService makanan = MakananService();
    return MakananForm(
      imagePickerLabel: 'Tambah gambar',
      saveButtonLabel: 'Simpan',
      restoran: restoran,
    );
  }
}
