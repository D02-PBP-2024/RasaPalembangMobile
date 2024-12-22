import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/forum_form.dart';

class ForumTambahPage extends StatelessWidget {
  final String restoran;

  const ForumTambahPage({super.key, required this.restoran});

  @override
  Widget build(BuildContext context) {
    return ForumForm(
      saveButtonLabel: 'Tambah Forum',
      restoran: restoran,
    );
  }
}
