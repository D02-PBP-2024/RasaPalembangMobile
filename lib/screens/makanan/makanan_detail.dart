import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/widget/rp_makanan_detail.dart';

class MakananDetailPage extends StatelessWidget {
  final Makanan makanan;

  const MakananDetailPage({
    super.key,
    required this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    return RPMakananDetail(
      makanan: makanan,
    );
  }
}