import 'package:flutter/material.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/widget/restoran_form.dart';

class RestoranEditForm extends StatelessWidget {
  final Restoran restoran;

  const RestoranEditForm({
    super.key,
    required this.restoran,
  });

  @override
  Widget build(BuildContext context) {
    return RestoranFormPage(
      imagePickerLabel: 'Edit gambar',
      saveButtonLabel: 'Simpan',
      restoran: restoran,
      edit: true,
    );
  }
}