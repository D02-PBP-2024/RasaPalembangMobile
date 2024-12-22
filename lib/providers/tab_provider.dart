import 'package:flutter/material.dart';

class TabProvider extends ChangeNotifier {
  int _tab = 0;

  int get tab => _tab;

  set tab (int newTab) {
    _tab = newTab;
    notifyListeners();
  }
}
