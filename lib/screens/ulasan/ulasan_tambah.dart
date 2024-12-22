import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/ulasan_form.dart';

class UlasanTambahPage extends StatelessWidget {
  final String restoran;

  const UlasanTambahPage({super.key, required this.restoran});

  @override
  Widget build(BuildContext context) {
    return UlasanForm(
      saveButtonLabel: 'Tambah Ulasan',
      restoran: restoran,
    );
  }
}
