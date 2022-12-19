import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/screens/favoritescreen/favorite_button.dart';
import 'package:music_app/screens/homescreen/allsongs/playlistscreen.dart';
import 'package:music_app/screens/homescreen/allsongs/allsongs.dart';


Future moredialog(BuildContext context,index) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      contentPadding:const EdgeInsets.only(top: 7, bottom: 7),
      shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor:Color.fromARGB(255, 13, 139, 146), 
      children: [
       
       const SizedBox(height: 7,),
        SimpleDialogOption(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PlaylistScreenFromallsong(findex: index,))); 
          },
          child: Row(
            children:const [
            Icon( Icons.playlist_add, color: Colors.white,
              ),
             SizedBox(width: 4),
              Text( 'Add to playlist',
                 style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                   ),
              ),
            ],),
        ),
        SimpleDialogOption(  
          child: Row(
            children: [ 
           const Icon(Icons.favorite,color: Colors.white,),          
           FavoriteButton(songFavorite: startSong[index]),   
                 ],
           ),),
       ],),
     );
   }