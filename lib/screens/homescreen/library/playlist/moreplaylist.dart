import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/db/functions/playlist_db.dart';
import 'package:music_app/db/model/muzic_model.dart';

Future moredialogplaylist( context,index,musicList,formkey,playlistnamectrl) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      contentPadding:const EdgeInsets.only(top: 10, bottom: 8),
      shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor:Color.fromARGB(255, 12, 137, 144),
      children: [
        SimpleDialogOption(
          onPressed: () {
            Navigator.of(context).pop(); 
            playlistnamectrl.clear();
            editplaylist(index, context,formkey,playlistnamectrl);
          },
          child: Row(
            children: const [
            Icon(Icons.edit, color: Colors.white,),
             SizedBox(width: 4),
              Text( 'Edit playlist Name',
                style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                   ),
              ),
            ],),
        ),
        const SizedBox(height: 8,),
        SimpleDialogOption(
          onPressed: () {

              Navigator.of(context).pop();  
               showdialog(context, musicList, index); 

                  },         
            child: Row(
            children: const [
            Icon( Icons.delete, color: Color.fromARGB(255, 227, 8, 8), 
              ),
             SizedBox(width: 4),
              Text( 'Delete',
                 style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                   ),
              ),
            ],),
        ),
      ],),
  );
}


Future<dynamic> showdialog(context, musicList, index) {
  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor:const Color.fromARGB(255, 15, 159, 167), 
                        title: const Text('Delete Playlist',
                         style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                   ),),
                        content: const Text(
                            'Are you sure you want to delete this playlist?',
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
                              musicList.deleteAt(index);
                              Navigator.pop(context);
                              const snackBar = SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Playlist is deleted',
                                  style: TextStyle(color: Colors.white),
                                ),
                                duration: Duration(milliseconds: 350),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
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
          }

  Future editplaylist(index,context,formkey,playlistnamectrl) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor:const Color.fromARGB(255, 15, 159, 167),
      children: [
        const SimpleDialogOption(
          child: Text(
            'Edit Playlist Name',
             style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                   ),
          ),
        ),
        const SizedBox( height: 8,),
        SimpleDialogOption(
          child: Form(
            key:formkey, 
            child: TextFormField(
               controller: playlistnamectrl,   
              decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  contentPadding:const EdgeInsets.only(left: 15, top: 5)),
                 style: const TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                   ),
                  validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your playlist name";
                        } else {
                          return null;
                        }
                      },
            ),
          ),
        ),
       const SizedBox( height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                
              },
              child: const Text( 'Cancel',
                 style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                   ),
              ),
            ),
                 SimpleDialogOption(
                  onPressed: () {
            
                     updateplaylistname(index,formkey,playlistnamectrl);  
                      Navigator.of(context).pop(); 
              },
              child: const Text( 'Update', 
                style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                   ),
              ), ),
          ],
        ),
      ],),
  );
} 



void updateplaylistname(index,formkey,playlistnamectrl) {
    if (formkey.currentState!.validate()) {
      final names = playlistnamectrl.text.trim();
    if(names.isEmpty){
      return;}
      else{
      final playlistnam = MuzicModel(
        name: names,
      songId: []
      );
     PlaylistDb. editList(
        index,            
        playlistnam
      );
      }
    }
  }