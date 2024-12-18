import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/size_constants.dart';

class RpSquaredImageButton extends StatelessWidget {
  final String? label;
  final double? width;
  final double? height;
  final IconData icon;
  final VoidCallback onTap;

  const RpSquaredImageButton({
    super.key,
    this.width,
    this.height,
    this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: width ?? 100,
            height: height ?? 100,
            decoration: BoxDecoration(
              color: RPColors.textFieldBackground,
              borderRadius: BorderRadius.circular(RPSize.cornerRadius),
            ),
            child: Center(
              child: Icon(icon, color: RPColors.textFieldPlaceholder),
            ),
          ),
        ),
        if (label != null) ...[
          SizedBox(height: 8.0),
          Text(label!),
        ],
      ],
    );
  }
}
