import 'package:flutter/material.dart';
import 'package:music_app/providers/splashProvider.dart'; 
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<splash>(context,listen: false).timerSplash(context);
    return Scaffold(
      backgroundColor: Colors.black, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/loogoo.png",
              height: 350,
              width: 250,
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
}

