import 'package:flutter/material.dart';
import 'package:rasapalembang/models/ulasan.dart';
import 'package:rasapalembang/widget/ulasan_form.dart';

class UlasanEditPage extends StatelessWidget {
  final Ulasan ulasan;

  UlasanEditPage({
    super.key,
    required this.ulasan,
  });

  @override
  Widget build(BuildContext context) {
    return UlasanForm(
      ulasan: ulasan,
      saveButtonLabel: 'Simpan',
      restoran: ulasan.restoran,
      edit: true,
    );
  }
}
