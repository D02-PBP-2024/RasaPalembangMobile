import 'package:flutter/material.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/widget/minuman_form.dart';

class MinumanTambahPage extends StatelessWidget {
  const MinumanTambahPage({super.key});

  @override
  Widget build(BuildContext context) {
    MinumanService minuman = MinumanService();
    return MinumanForm(
      imagePickerLabel: 'Tambah Gambar',
      saveButtonLabel: 'Tambah',
    );
  }
}
