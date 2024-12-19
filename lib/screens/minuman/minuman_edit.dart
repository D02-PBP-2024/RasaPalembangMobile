import 'package:flutter/material.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/widget/minuman_form.dart';

class MinumanEditPage extends StatelessWidget {
  final Minuman minuman;

  MinumanEditPage({
    super.key,
    required this.minuman,
  });

  @override
  Widget build(BuildContext context) {
    return MinumanForm(
      imagePickerLabel: 'Edit gambar',
      saveButtonLabel: 'Simpan',
      minuman: minuman,
      restoran: minuman.restoran,
      edit: true,
    );
  }
}
