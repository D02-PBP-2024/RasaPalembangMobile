import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/size_constants.dart';

class RPDraggableBottomSheet {
  final BuildContext context;
  final List<Widget> widgets;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;

  RPDraggableBottomSheet({
    this.initialChildSize = 0.9,
    this.minChildSize = 0.1,
    this.maxChildSize = 0.9,
    required this.context,
    required this.widgets
  });

  void show() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(RPSize.cornerRadius),
        ),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          builder: (context, scrollController) {
            return ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(RPSize.cornerRadius),
              ),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 5,
                      width: 50,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: <Widget>[
                            ...widgets,
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
