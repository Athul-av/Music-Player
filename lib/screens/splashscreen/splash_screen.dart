import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:music_app/screens/homescreen/allsongs/allsongs.dart';
import 'package:music_app/screens/homescreen/allsongs/bottom_miniplayer_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToHome(context); 
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                "assets/images/loogoo.png",
                height: 350,
                width: 250,
              ), 
            ),
            const Text(
              'PAATTU', 
              style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 15, 159, 167),
                    fontSize: 27,
                  
                    fontWeight: FontWeight.w800
                   ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Future<void> goToHome(context) async {
  Timer(const Duration(seconds: 2), (() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>   BottomNavigationScreen()));  
  }));
}
