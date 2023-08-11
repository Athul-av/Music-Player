import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/db/functions/playlist_db.dart';
import 'package:music_app/db/model/muzic_model.dart';
import 'package:music_app/screens/homescreen/library/playlist/playlist_listview.dart';

class PlaylistScreen extends StatelessWidget {
   PlaylistScreen({
    super.key,
  });
 
TextEditingController nameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
           Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0) 
          ],
        ),
      ),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<MuzicModel>('playlistDb').listenable(),
          builder:
            (BuildContext context, Box<MuzicModel> musicList, Widget? child) {
          return Scaffold(
            resizeToAvoidBottomInset: false, 
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title:  const Text('Playlist',
               style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 15, 159, 167),
                    fontSize: 26,
                    
                   ),),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0, 
              ),
              floatingActionButton: FloatingActionButton(
              onPressed: () {
                nameController.clear(); 
              newplaylist(context,_formKey); 
              },
              backgroundColor:const Color.fromARGB(255, 13, 135, 142),
              child:const Icon( 
            Icons.playlist_add,color: Color.fromARGB(255, 255, 255, 255), 
          ),
          ),
            body: Padding(
              padding: const EdgeInsets.all(8.0), 
               child: SingleChildScrollView(
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Hive.box<MuzicModel>('playlistDb').isEmpty
                        ?const  Padding(
                            padding:  EdgeInsets.symmetric(
                                vertical: 100, horizontal: 50),
                            child: Center(
                              child: Padding(
                                padding:  EdgeInsets.all(80.0),
                                child: Column(
                                  children:  [      
                                     Text(
                                      'No Playlist',  
                                      style: TextStyle(
                                 fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18,   
                              ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : PlaylistListListView(
                         musicList: musicList,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future newplaylist(BuildContext context,formKey) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor:const Color.fromARGB(255, 10, 126, 132),
      children: [
        const SimpleDialogOption(
          child: Text(
            'New to Playlist',
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
            key:formKey, 
            child: TextFormField(
               controller: nameController,
               maxLength: 15,     
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
                nameController.clear(); 
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
               if (_formKey.currentState!.validate()) {
                    saveButtonPressed(context);
                    }
                  
              },
              child: const Text( 'Create', 
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

  Future<void> saveButtonPressed(context) async {
    final name = nameController.text.trim();
     final music = MuzicModel(name: name, songId: []);

     final datas = PlaylistDb.playlistDb.values.map((e) => e.name.trim()).toList();
    if (name.isEmpty) {
      return;
    } else if(datas.contains(music.name)){

   const snackbar3 = SnackBar(
          duration:
   Duration(milliseconds: 750), 
          backgroundColor: Colors.black,
        content:Text('playlist already exist',
        style: TextStyle(color: Colors.white),  ) ); 
         ScaffoldMessenger.of(context).showSnackBar(snackbar3);  
          Navigator.of(context).pop(); 
    }  
    
    else {
     
      PlaylistDb.addPlaylist(music);
      const snackbar4 = SnackBar(
          duration:
   Duration(milliseconds: 750), 
          backgroundColor: Colors.black,
        content:Text('playlist created successfully', 
        style: TextStyle(color: Colors.white),  ) ); 
         ScaffoldMessenger.of(context).showSnackBar(snackbar4);  
     Navigator.of(context).pop();  
    }
  }
}


