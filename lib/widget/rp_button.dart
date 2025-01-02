import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/size_constants.dart';

class RPButton extends StatelessWidget {
  final String label;
  final double? width;
  final VoidCallback onPressed;
  final bool isLoading;

  const RPButton({
    super.key,
    required this.label,
    this.width,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 40.0,
      child: ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(RPColors.biruMuda),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(RPSize.cornerRadius),
            ),
          ),
        ),
        child: !isLoading
          ? Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            )
          : SizedBox(
              width: 18.0,
              height: 18.0,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3.0,
              ),
            ),
      ),
    );
  }
}
