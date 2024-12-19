import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/forum_form.dart';

class ForumTambahPage extends StatelessWidget {
  const ForumTambahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ForumForm(
      saveButtonLabel: 'Tambah Forum',
    );
  }
}
