import 'package:flutter/material.dart';
import 'package:rasapalembang/models/balasan.dart';
import 'package:rasapalembang/widget/balasan_form.dart';

class BalasanEditPage extends StatelessWidget {
  final Balasan balasan;

  BalasanEditPage({
    super.key,
    required this.balasan,
  });

  @override
  Widget build(BuildContext context) {
    return BalasanForm(
      balasan: balasan,
      saveButtonLabel: 'Simpan',
      forum: balasan.forum,
      edit: true,
    );
  }
}
