import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RPImageLoading extends StatelessWidget {
  final double width;
  final double height;

  const RPImageLoading({
    super.key,
    this.width = 50.0,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
