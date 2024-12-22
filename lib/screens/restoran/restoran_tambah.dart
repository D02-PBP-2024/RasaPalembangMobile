import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/restoran_form.dart';

class RestoranTambahPage extends StatelessWidget {
  const RestoranTambahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RestoranFormPage(
      imagePickerLabel: 'Tambah gambar',
      saveButtonLabel: 'Simpan',
    );
  }
}
