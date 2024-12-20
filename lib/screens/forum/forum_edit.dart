import 'package:flutter/material.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/widget/forum_form.dart';

class ForumEditPage extends StatelessWidget {
  final Forum forum;

  ForumEditPage({
    super.key,
    required this.forum,
  });

  @override
  Widget build(BuildContext context) {
    return ForumForm(
      forum: forum,
      saveButtonLabel: 'Simpan',
      restoran: forum.restoran,
      edit: true,
    );
  }
}
