import 'package:flutter/material.dart';

class RPListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final double paddingTop;
  final double paddingBottom;

  const RPListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.paddingTop = 8.0,
    this.paddingBottom = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: paddingTop),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: itemCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: itemBuilder,
          ),
          SizedBox(height: paddingBottom),
        ],
      ),
    );
  }
}
