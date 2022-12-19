import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/db/model/muzic_model.dart';
import 'package:music_app/screens/homescreen/library/playlist/moreplaylist.dart';
import 'package:music_app/screens/homescreen/library/playlist/playlist_added_song_screen.dart';
import 'package:google_fonts/google_fonts.dart';


class PlaylistListListView extends StatefulWidget {
  PlaylistListListView({
  Key? key, required this.musicList,}) : super(key: key);
  Box <MuzicModel> musicList;

  @override
  State<PlaylistListListView> createState() => _PlaylistListListViewState();
}

class _PlaylistListListViewState extends State<PlaylistListListView> {

final TextEditingController playlistnamectrl =TextEditingController();
GlobalKey<FormState> formkey = GlobalKey<FormState>();

@override
  void initState() {
    playlistnamectrl.text=  widget.musicList.name; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
     gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2),  
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.musicList.length,
      itemBuilder: (context, index) {
        final data = widget.musicList.values.toList()[index];

        return ValueListenableBuilder(
          valueListenable: Hive.box<MuzicModel>('playlistDb').listenable(),
          builder:
              (BuildContext context, Box<MuzicModel> musicList, Widget? child) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ListOfPlayList(
                    findex: index,
                    playlist: data,
                  ); 
                }));
                  },
                  child: Card(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  const Expanded(
                                    flex: 3, 
                                    child:Icon(Icons.folder,color:Color.fromARGB(255, 15, 159, 167),size: 145,)     
                                  ),
                                  Expanded(
                                      child: Container(
                                       
                                    padding:const EdgeInsets.only(left: 32,right: 9), 
                                    child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     
                                      children: [
                                          
                                        Text( data.name, 
                                           style: const TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17, 
                    fontWeight: FontWeight.w600 
                   ),
                                           ),
                                           
                                         IconButton(onPressed: (){
                                         moredialogplaylist(context,index,musicList,formkey,playlistnamectrl);   
 
                                    }, icon:const Icon(Icons.more_vert,color: Colors.white,))
                                       
                           ],
                         ),
                      ))
                   ],),
                ),
             );
          },
        );
      }
    ); 
   }
}