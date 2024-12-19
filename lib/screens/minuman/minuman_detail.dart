import 'package:flutter/material.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/widget/rp_minuman_detail.dart';

class MinumanDetailPage extends StatelessWidget {
  final Minuman minuman;

  const MinumanDetailPage({
    super.key,
    required this.minuman,
  });

  @override
  Widget build(BuildContext context) {
    return RPMenuDetail(
      minuman: minuman,
    );
  }
}
