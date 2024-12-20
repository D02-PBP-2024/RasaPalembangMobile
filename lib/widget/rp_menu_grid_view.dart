import 'package:flutter/material.dart';

class RPMenuGridView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final double childAspectRatio;
  final double paddingTop;
  final double paddingBottom;

  const RPMenuGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.childAspectRatio = 0.674,
    this.paddingTop = 8.0,
    this.paddingBottom = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: paddingTop),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: itemCount,
              itemBuilder: itemBuilder,
            ),
          ),
          SizedBox(height: paddingBottom),
        ],
      ),
    );
  }
}
