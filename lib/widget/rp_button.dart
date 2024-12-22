import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/size_constants.dart';

class RPButton extends StatelessWidget {
  final String label;
  final double? width;
  final VoidCallback onPressed;

  const RPButton({
    super.key,
    required this.label,
    this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 40.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(RPColors.biruMuda),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(RPSize.cornerRadius),
            ),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
