import 'package:flutter/material.dart';

class NavBarProvider extends ChangeNotifier {
  int _index = 0;
  int get currentIndex => _index;

  void changeIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
