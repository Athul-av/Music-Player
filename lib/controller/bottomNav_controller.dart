import 'package:flutter/cupertino.dart';

class BottomNavController extends ChangeNotifier {
  int _currentIndex = 2;
  get currentIndex => _currentIndex;
  set currentIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }
}