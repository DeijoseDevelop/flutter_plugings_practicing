import 'package:flutter/material.dart';

class SliderModel extends ChangeNotifier {
  double _currentPage = 0;

  double get currentPage => _currentPage;

  set currentPage(double newPage) {
    _currentPage = newPage;
    // print('newPage: $newPage');
    notifyListeners();
  }
}
