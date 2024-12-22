import 'package:flutter/material.dart';

class RPImageError extends StatelessWidget {
  final double width;
  final double height;

  const RPImageError({
    super.key,
    this.width = 50.0,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Icon(
        Icons.error_outline,
        color: Colors.grey,
        size: 24.0,
      ),
    );
  }
}
