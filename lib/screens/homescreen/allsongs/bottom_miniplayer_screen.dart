import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_app/controller/bottomNav_controller.dart';
import 'package:music_app/controller/get_all_song_controller.dart';
import 'package:music_app/db/functions/favorite_db.dart';
import 'package:music_app/screens/favoritescreen/favorite_screen.dart';
import 'package:music_app/screens/homescreen/allsongs/allsongs.dart';
import 'package:music_app/screens/homescreen/library/mostly/mostly_played.dart';
import 'package:music_app/screens/homescreen/library/playlist/playlist_create_screen.dart';
import 'package:music_app/screens/homescreen/library/recently/recently_played.dart';
import 'package:music_app/screens/miniplayer/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});

  int currentIndex = 2; 

  List <Widget>pages = [ 
    MostlyPlayed(),
    RecentlyPlayed(),
    HomeScreen(),
    FavoriteScreen(), 
    PlaylistScreen(),

   
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavController>(
      builder: (context, value, child) {
        
      
      return Scaffold(
        backgroundColor: Colors.transparent,
        
        
        bottomNavigationBar:Padding(padding: EdgeInsets.all(6),
        child :SingleChildScrollView(
          physics: ScrollPhysics(),
              child: Column(
                children: [
                  if (GetAllSongController.audioPlayer.currentIndex != null)
                    Column(
                      children: const [
                        MiniPlayer(),
                        
                      ],
                    ) ,
                   Consumer<BottomNavController>(
                          builder: (context,value,child) {
                        return  GNav(
                          backgroundColor: Color.fromARGB(255, 0, 0, 0), 
                          tabBackgroundColor: Color.fromARGB(255, 15, 159, 167),
                          selectedIndex: value.currentIndex, 
                          onTabChange: (index) {
                            currentIndex =index;
                            value.currentIndex = currentIndex;

                          },
                          padding: EdgeInsets.all(12),
                          activeColor: Colors.white, 
                          
                          tabs: const [ 
                         GButton(icon: Icons.graphic_eq, iconColor: Color.fromARGB(255, 15, 159, 167),   iconSize: 27,
                         text:'Most played',
                          textStyle:TextStyle(
                             fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 15, 
                                fontWeight: FontWeight.w600   
                          ),
                        
                               ),
                          GButton(icon: Icons.history, iconColor: Color.fromARGB(255, 15, 159, 167),  iconSize: 27,
                         text:'Recents',  
                         textStyle:TextStyle(
                             fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 15, 
                                 fontWeight: FontWeight.w600   
                          ), ),
                          GButton(icon: Icons.headphones_outlined,  iconColor: Color.fromARGB(255, 15, 159, 167), iconSize: 27,
                         text:'All songs', 
                         textStyle:TextStyle(
                             fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 15, 
                                fontWeight: FontWeight.w600   
                          ) ,),
                          GButton(icon: Icons.favorite_outline, iconColor: Color.fromARGB(255, 15, 159, 167),iconSize: 27,
                         text:'Favorite',
                         textStyle:TextStyle(
                             fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 15, 
                                fontWeight: FontWeight.w600   
                          ), ),
                          GButton(icon: Icons.library_music_outlined, iconColor: Color.fromARGB(255, 15, 159, 167), iconSize: 27,
                         text:'playlist',
                        textStyle:TextStyle(
                             fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 15, 
                                fontWeight: FontWeight.w600   
                          ),), 
                        ],
                        
                       
                        );
                      }),
                    ]),
                  ),
                
              ),
               body: pages[value.currentIndex],
            );
    
        
       
        
      
    
  }

 ); }
}