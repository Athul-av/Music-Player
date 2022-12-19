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

class BottomNavigationScreen extends StatelessWidget {
  BottomNavController bottomNavController = Get.put(BottomNavController());
  BottomNavigationScreen({super.key});

  int currentIndex = 2; 

  List pages =const [ 
    MostlyPlayed(),
    RecentlyPlayed(),
    HomeScreen(),
    FavoriteScreen(), 
    PlaylistScreen(),

   
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<BottomNavController>(
          builder: (controller) => pages[bottomNavController.currentIndex],
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: FavoriteDb.favoriteSongs,
          builder:
              (BuildContext context, List<SongModel> music, Widget? child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (GetAllSongController.audioPlayer.currentIndex != null)
                    Column(
                      children: const [
                        MiniPlayer(),
                        
                      ],
                    ) 
                  else
                    const SizedBox(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.086,
                   
                    child: ClipRRect(
                     
                      child: GetBuilder<BottomNavController>(
                          builder: (controller) {
                        return  GNav(
                          backgroundColor: Color.fromARGB(255, 0, 0, 0), 
                          tabBackgroundColor: Color.fromARGB(255, 15, 159, 167),
                          selectedIndex: 2, 
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
 
                        onTabChange:(index) {
                            currentIndex = index; 
                            bottomNavController.currentIndex = index;
                          },
                        
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}