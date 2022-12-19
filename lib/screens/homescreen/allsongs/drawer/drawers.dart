import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/controller/get_all_song_controller.dart';
import 'package:music_app/db/functions/playlist_db.dart';
import 'package:music_app/screens/homescreen/allsongs/drawer/drawerAboutUs.dart';
import 'package:music_app/screens/homescreen/allsongs/drawer/drawerPrivacy.dart';
import 'package:music_app/screens/homescreen/allsongs/drawer/shareApp.dart'; 


class HomescreenDrawers extends StatelessWidget {
  const HomescreenDrawers({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 14, 14, 14), 
      child: SafeArea(
          child: Column(children: [
            Container(
              height: 200,
              width: 230,  
              child: Image.asset('assets/images/loogoo.png')),  
           
            Column(children: [ 
              Padding(
                 padding: const EdgeInsets.fromLTRB(18.0,18,18,8),
                child: Row(
                  children: [
                    Icon(Icons.person,color:  Color.fromARGB(255, 15, 159, 167),), 
                    TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AboutUsDrawer())); 
                    },
                       child:const Text( 'About Us ',
                         style: TextStyle(
                                 fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18, 
                                fontWeight: FontWeight.w600  
                              ),
                      ),
                    ),
                  ],
                ),
              ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(18.0,18,18,8),
                child: Row(
                  children: [ 
                    Icon(Icons.lock_person_rounded,color:  Color.fromARGB(255, 15, 159, 167),), 
                    TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PrivacyDrawer()));
                    },
                       child:const Text( 'Privacy & Policy',
                         style: TextStyle(
                                 fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18, 
                                fontWeight: FontWeight.w600  
                              ),
                      ),
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.fromLTRB(18.0,18,18,8),
                child: Row(
                  children: [ 
                    Icon(Icons.share,color:  Color.fromARGB(255, 15, 159, 167),), 
                    TextButton(onPressed: (){
                          ShareAppFile(context); 
                    },
                       child:const Text( 'Share App', 
                         style: TextStyle(
                                 fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18, 
                                fontWeight: FontWeight.w600  
                              ),
                      ),
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.fromLTRB(18.0,18,18,8),
                child: Row(
                  children: [ 
                    Icon(Icons.replay,color:  Color.fromARGB(255, 15, 159, 167),), 
                    TextButton(onPressed: (){
                            showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor:const Color.fromARGB(255, 15, 159, 167), 
                        title: const Text('Reset App',
                         style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                   ),),
                        content: const Text(
                            "Are you sure you want to reset the App?       your saved datas will be deleted ",
                              
                            style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15,
                    
                   ),),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child:  const Text('No', style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15,
                  
                   ),),
                          ), 
                          TextButton(
                            onPressed: () {
                             PlaylistDb.resetAPP(context);
                           GetAllSongController.audioPlayer.stop(); 
                            },
                            child: const Text('Yes', style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15,
                   
                   ),),
                          ), 
                       ],
                    );
                 },
             );
                    },
                       child:const Text( 'Reset App',  
                         style: TextStyle(
                                 fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18, 
                                fontWeight: FontWeight.w600  
                              ),
                      ),
                    ),
                  ], 
                ),
              ),
          ]),
          ]),
        ),
    );
  }
}
 

  