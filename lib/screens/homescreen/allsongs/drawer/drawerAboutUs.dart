import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsDrawer extends StatelessWidget {
  const AboutUsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( 
        decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 0, 0, 0),
        ],
      ),
        ),
        child: Padding(
      padding: const EdgeInsets.all(80.0),
      child: Column(
        children: const [
         
          Text(
            """
Welcome to Paattu Player Endless Music, 

your number one source for all things Music. We're dedicated to providing you the best of Music, with a focus on dependability. customer service,.

We're working to turn our passion for music into a booming Music Player. We hope you enjoy our Music as much as we enjoy offering them to you.

Sincerely,

Athul A V""",
            style: TextStyle(
                                 fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 15, 159, 167),
                                fontSize: 19,   
                              ), 
          )
        ],
      ),
        ),
      ),
    );
  }
}