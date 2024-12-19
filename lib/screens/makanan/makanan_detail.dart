import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/widget/rp_minuman_detail.dart';

class MakananDetailPage extends StatelessWidget {
  final Makanan makanan;

  const MakananDetailPage({
    super.key,
    required this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    return Text('wkwk');
  }

  String _title(String string) {
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }
}