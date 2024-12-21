import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/balasan_form.dart';

class BalasanTambahPage extends StatelessWidget {
  final String forum;

  const BalasanTambahPage({
    super.key, 
    required this.forum,
  });

  @override
  Widget build(BuildContext context) {
    return BalasanForm(
      forum: forum,
      saveButtonLabel: 'Tambah Balasan',
    );
  }
}
