// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:music_app/screens/favoritescreen/favorite_screen.dart';
// import 'package:music_app/screens/homescreen/library/mostly/mostly_played.dart';
// import 'package:music_app/screens/homescreen/library/playlist/playlist_create_screen.dart';
// import 'package:music_app/screens/homescreen/library/recently/recently_played.dart';


// class LibrarySection extends StatelessWidget {
//   const LibrarySection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//          Align(
//           alignment: Alignment.topLeft,
//           child: Text(
//             'Library',
//             style: GoogleFonts.ubuntuCondensed(
//            textStyle:const TextStyle( color: Color.fromARGB(255, 248, 245, 245)),
//               fontSize: 15), 
//           ),
//         ),
//         const SizedBox(height: 15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//                          GestureDetector(
//                                       onTap: () {
//                                          Navigator.of(context).push( MaterialPageRoute( builder: (context) => RecentlyPlayed()));  
//                                       },
//                                        child: Container(
//                                         height: MediaQuery.of(context).size.height * 0.12,
//                                         width:MediaQuery.of(context).size.width * 0.2,
                                        
//                                          decoration:const BoxDecoration(
//                                           image: DecorationImage(image: AssetImage('assets/images/recent image.jpg'), 
//                                           fit: BoxFit.cover),
//                                           borderRadius: BorderRadius.all(Radius.circular(10))),  
//                                           child: Column(
                                            
//                                             mainAxisAlignment: MainAxisAlignment.center, 
                                            
//                                             children:[ Align(
//                                               alignment: Alignment.center,
//                                               child: Text( "Recently ", 
//                                                 style: GoogleFonts.ubuntuCondensed(
//                                                     textStyle:const TextStyle(
//                                                         color: Color.fromARGB(255, 255, 255, 255)),
//                                                     fontWeight: FontWeight.w600,fontSize: 16), 
//                                               ),
//                                             ),
//                                             Align(
//                                               alignment: Alignment.center, 
//                                               child: Text( " Played", 
//                                                 style: GoogleFonts.ubuntuCondensed(
//                                                     textStyle:const TextStyle(
//                                                         color: Color.fromARGB(255, 255, 255, 255)),
//                                                     fontWeight: FontWeight.w600,fontSize: 16), 
//                                               ),
//                                             ),
//                                      ]),
//                                         ),
//                                      ),
//                                     SizedBox(width: MediaQuery.of(context).size.width*0.03,),
//                                      GestureDetector(
//                                       onTap: () {
//                                          Navigator.of(context).push( MaterialPageRoute( builder: (context) => MostlyPlayed())); 
//                                       }, 
//                                        child: Container(
//                                         height: MediaQuery.of(context).size.height * 0.12,
//                                         width:MediaQuery.of(context).size.width * 0.2,
//                                         padding: EdgeInsets.only(left:15),
//                                          decoration:const BoxDecoration(
//                                           image: DecorationImage(image: AssetImage('assets/images/Mostlyplayed.jpg'),fit: BoxFit.cover),
//                                            borderRadius: BorderRadius.all(Radius.circular(10))), 
//                                           child: Center(
//                                             child: Text( "Mostly Played",
//                                               style: GoogleFonts.ubuntuCondensed(
//                                                   textStyle:const TextStyle(
//                                                       color: Color.fromARGB(255, 255, 255, 255)),
//                                                   fontWeight: FontWeight.w600,fontSize: 16),
//                                             ),
//                                           ),
//                                         ),
//                                      ),
//                                     SizedBox(width: MediaQuery.of(context).size.width*0.03,),
//                                      GestureDetector(
//                                       onTap: () {
//                                          Navigator.of(context).push( MaterialPageRoute( builder: (context) => PlaylistScreen())); 
//                                       },
//                                        child: Container(
//                                         height: MediaQuery.of(context).size.height * 0.12,
//                                         width:MediaQuery.of(context).size.width * 0.2,
//                                          decoration:const BoxDecoration(
//                                           image: DecorationImage(image: AssetImage('assets/images/Playlist.jpg'),fit: BoxFit.cover),
//                                            borderRadius: BorderRadius.all(Radius.circular(10))), 
//                                           child: Center( 
//                                             child: Text( "Playlist",
//                                               style: GoogleFonts.ubuntuCondensed(
//                                                   textStyle:const TextStyle(
//                                                       color: Color.fromARGB(255, 255, 255, 255)),
//                                                   fontWeight: FontWeight.w600,fontSize: 17),
//                                             ),
//                                           ),
//                                         ),
//                                      ),
//                                     SizedBox(width: MediaQuery.of(context).size.width*0.03,),
//                                      GestureDetector(
//                                       onTap: () {
//                                          Navigator.of(context).push( MaterialPageRoute( builder: (context) => FavoriteScreen())); 
//                                       },
//                                        child: Container(
//                                         height: MediaQuery.of(context).size.height * 0.12, 
//                                         width:MediaQuery.of(context).size.width * 0.2,
//                                          decoration:const BoxDecoration(
//                                           image: DecorationImage(image: AssetImage('assets/images/Favorite.jpg'),fit: BoxFit.cover),
//                                            borderRadius: BorderRadius.all(Radius.circular(10))), 
//                                           child: Center(
//                                             child: Text( "Favorite",
//                                               style: GoogleFonts.ubuntuCondensed(
//                                                   textStyle:const TextStyle(
//                                                       color: Color.fromARGB(255, 255, 255, 255)),
//                                               fontWeight: FontWeight.w600,fontSize: 17),
//                                 ),
//                          ),
//                       ),
//                   ),                       
//           ],
//         ), 
//       ],
//     );
//   }
// }
