import 'package:flutter/material.dart';

class RPMenuGridView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final double paddingTop;
  final double gap;
  final double paddingBottom;

  const RPMenuGridView({
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
      itemCount: (itemCount / 2).ceil(),
      itemBuilder: (context, rowIndex) {
        final startIndex = rowIndex * 2;
        final endIndex = (startIndex + 2) > itemCount
          ? itemCount
          : startIndex + 2;

        List<int> rowItems = List.generate(endIndex - startIndex, (index) => startIndex + index);
        if (itemCount % 2 == 1 && rowIndex == (itemCount / 2).ceil() - 1) {
          rowItems.add(-1);
        }

        return Column(
          children: [
            if (rowIndex == 0) SizedBox(height: paddingTop),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: rowItems.map((index) {
                if (index == -1) {
                  return Expanded(
                    child: Padding(
                      padding: index % 2 == 0 ? EdgeInsets.only(right: gap) : EdgeInsets.zero,
                      child: SizedBox(),
                    ),
                  );
                }
                return Expanded(
                  child: Padding(
                    padding: index % 2 == 0 ? EdgeInsets.only(right: gap) : EdgeInsets.zero,
                    child: itemBuilder(context, index),
                  ),
                );
              }).toList(),
            ),
            if (rowIndex < (itemCount / 2).ceil() - 1) SizedBox(height: gap),
            if (rowIndex == (itemCount / 2).ceil() - 1) SizedBox(height: paddingBottom),
          ],
        );
      },
    );
  }
}
