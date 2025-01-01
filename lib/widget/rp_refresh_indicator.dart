import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class RPRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const RPRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: RPColors.biruMuda,
      backgroundColor: Colors.white,
      child: child,
    );
  }
}