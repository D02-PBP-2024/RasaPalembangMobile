import 'package:flutter/material.dart';
import 'package:rasapalembang/screens/authentication/show_login_bottom.dart';
import 'package:rasapalembang/widget/rp_draggable_bottom_sheet.dart';
import 'package:rasapalembang/widget/rp_register.dart';

void showRegisterBottom(BuildContext context) {
  RPDraggableBottomSheet(
    maxChildSize: 1,
    context: context,
    widgets: [
      const SizedBox(height: 32.0),
      RPRegister(
        redirect: () {
          Navigator.pop(context);
        },
        loginPage: () {
          Navigator.pop(context);
          showLoginBottom(context);
        }
      ),
    ],
  ).show();
}
