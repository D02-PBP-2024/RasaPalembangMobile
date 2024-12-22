import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/widget/makanan_form.dart';

class MakananEditPage extends StatelessWidget {
  final Makanan makanan;

  MakananEditPage({
    super.key,
    required this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    return MakananForm(
      imagePickerLabel: 'Edit gambar',
      saveButtonLabel: 'Simpan',
      makanan: makanan,
      restoran: makanan.restoran,
      edit: true,
    );
  }
}
