import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/size_constants.dart';

class RPBottomSheet {
  final BuildContext context;
  final List<Widget> widgets;

  RPBottomSheet({required this.context, required this.widgets});

  void show() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(RPSize.cornerRadius),
          ),
          child: SingleChildScrollView(
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
                  ...widgets,
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
