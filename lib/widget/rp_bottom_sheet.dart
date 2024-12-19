import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/size_constants.dart';

class RPBottomSheet {
  final BuildContext context;
  final List<BottomSheetOption> options;

  RPBottomSheet({required this.context, required this.options});

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
                  ...options.map((option) => ListTile(
                    leading: Icon(
                      option.icon,
                      color: option.iconColor,
                    ),
                    title: Text(
                      option.title,
                      style: TextStyle(
                        color: option.textColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      option.onTap();
                    },
                  )),
                  const SizedBox(height: 16.0)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BottomSheetOption {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  BottomSheetOption({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });
}
