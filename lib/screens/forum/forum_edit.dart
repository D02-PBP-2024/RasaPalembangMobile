import 'package:flutter/material.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/widget/forum_form.dart';

class ForumEditPage extends StatelessWidget {
  final String topik;
  final String pesan;
  final String restoran;

  ForumEditPage({
    super.key,
    required this.topik,
    required this.pesan,
    required this.restoran,
  });

  @override
  Widget build(BuildContext context) {
    return ForumForm(
      initialTopik: topik,
      initialPesan: pesan,
      saveButtonLabel: 'Simpan',
      restoran: restoran,
      edit: true,
    );
  }
}
