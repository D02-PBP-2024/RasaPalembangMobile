import 'package:flutter/material.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/widget/minuman_form.dart';

class MinumanTambahPage extends StatelessWidget {
  final Restoran restoran;

  MinumanTambahPage({super.key, required this.restoran});

  @override
  Widget build(BuildContext context) {
    MinumanService minuman = MinumanService();
    return MinumanForm(
      imagePickerLabel: 'Tambah gambar',
      saveButtonLabel: 'Simpan',
      restoran: restoran,
    );
  }
}
