import 'package:flutter/material.dart';

class RPListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final double paddingTop;
  final double gap;
  final double paddingBottom;

  const RPListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.paddingTop = 8.0,
    this.gap = 8.0,
    this.paddingBottom = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Column(
          children: [
            if (index == 0) SizedBox(height: paddingTop),
            itemBuilder(context, index),
            if (index < itemCount - 1) SizedBox(height: gap),
            if (index == itemCount - 1) SizedBox(height: paddingBottom),
          ],
        );
      }
    );
  }
}
