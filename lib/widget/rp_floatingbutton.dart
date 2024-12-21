import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class RPFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String? tooltip;

  const RPFloatingButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      backgroundColor: RPColors.biruMuda,
      child: icon,
    );
  }
}
