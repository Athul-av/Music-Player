
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/controller/get_all_song_controller.dart';
import 'package:music_app/db/functions/recent_db.dart';
import 'package:music_app/providers/searchProvdr.dart';
import 'package:music_app/screens/musicplayingscreen/music_playing_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget { 
  const SearchScreen({super.key}); 

  @override 
  Widget build(BuildContext context) {
    
    Provider.of<SearchProvider>(context,listen: false).songsLoading();
    return Container(
      decoration:const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter, 
          colors: [
            Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0)  
          ],
        ), ),  
       child: Scaffold(
        resizeToAvoidBottomInset: false, 
        backgroundColor: Colors.transparent,
        
        body: Column(
          children: [
            Expanded(
              child: Container(
                color:  Color.fromARGB(255, 0, 0, 0), 
                child: SafeArea(
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop(); 
                      }, icon:const Icon(Icons.arrow_back),color: Colors.white,),
                     
                    SizedBox(
                      height: 50,
                      width: 300,  
                      child: Consumer<SearchProvider>(
                        builder:(context, value, child) {
                        return CupertinoSearchTextField(
                        borderRadius: BorderRadius.all(Radius.circular(25)),  
                        style: const TextStyle(
                                          fontFamily: 'UbuntuCondensed',
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 18,             
                                         ),
                          prefixIcon: const 
                                 Icon(
                                  Icons.search,
                                ), 
                              backgroundColor: Colors.white,  
                              onChanged: (keyword) => value.search(keyword),
                        );
                        }
                      ))
                    ],
                  ),
                ),
              )),
            Expanded(
              flex: 6,
              child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15,2,15,2), 
                    child: SafeArea(
                      child: Consumer<SearchProvider>(
                        builder: (context, value, child) {
                          
                       
                        return Column(
                          children: [
                            
                                value.foundSongs.isNotEmpty
                                ? ListView.separated(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                         tileColor: Color.fromARGB(255, 12, 12, 12), 
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        minVerticalPadding: 10.0,
                                        contentPadding: const EdgeInsets.all(0),
                                        leading: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: QueryArtworkWidget(
                                            id: value.foundSongs[index].id,
                                            type: ArtworkType.AUDIO,
                                            nullArtworkWidget: const Padding(
                                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                              child: Icon(Icons.music_note,color: Colors.white,size: 33,),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          value.foundSongs[index].title,
                                          maxLines: 1,
                                          style: const TextStyle(
                               fontFamily: 'UbuntuCondensed',
                                color: Color.fromARGB(255, 255, 255, 255),
                               fontSize: 18,  
                               ), 
                                        ),
                                        subtitle: Text(
                                          '${value.foundSongs[index].artist == "<unknown>" ? "Unknown Artist" : value.foundSongs[index].artist}',
                                          maxLines: 1,
                                           style: const TextStyle(
                                          fontFamily: 'UbuntuCondensed',
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontSize: 11,
                                         
                                         ),
                                        ),
                                        onTap: () {
                                          GetAllSongController.audioPlayer.setAudioSource(
                                              GetAllSongController.createSongList(
                                                value.foundSongs,
                                              ),
                                              initialIndex: index); 
                                          GetAllSongController.audioPlayer.play();
                                          GetRecentSong.addRecentlyPlayed(
                                              value.foundSongs[index].id); 
                                          Navigator.push(context,  
                                              MaterialPageRoute(builder: (context) {
                                            return MusicPlayingScreen(
                                              songModelList: value.foundSongs,
                                            );
                                          })); 
                                        },
                                      );
                                    },
                                    itemCount: value.foundSongs.length,
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        height: 10.0,
                                      );
                                    },
                                  )
                                : const Center(
                                    child:Text('No songs available',style: TextStyle(color: Colors.white),)),
                          ],
                        );
  }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ); 
  }
}