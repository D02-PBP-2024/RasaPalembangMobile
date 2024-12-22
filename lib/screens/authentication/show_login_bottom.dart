import 'package:flutter/material.dart';
import 'package:rasapalembang/screens/authentication/show_register_bottom.dart';
import 'package:rasapalembang/widget/rp_draggable_bottom_sheet.dart';
import 'package:rasapalembang/widget/rp_login.dart';

void showLoginBottom(BuildContext context) {
  RPDraggableBottomSheet(
    maxChildSize: 1,
    context: context,
    widgets: [
      const SizedBox(height: 32.0),
      RPLogin(
        redirect: () {
          Navigator.pop(context);
        },
        registerPage: () {
          Navigator.pop(context);
          showRegisterBottom(context);
        },
      ),
    ],
  ).show();
}
