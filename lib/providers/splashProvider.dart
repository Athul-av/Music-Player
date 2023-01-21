import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_app/screens/homescreen/allsongs/bottom_miniplayer_screen.dart';

class splash with ChangeNotifier{
   timerSplash(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return BottomNavigationScreen();
        },
      )),
    );
  }
}