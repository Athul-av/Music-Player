import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int _currentIndex = 2;
  get currentIndex => _currentIndex;
  set currentIndex(index) {
    _currentIndex = index;
    update();
  }
}