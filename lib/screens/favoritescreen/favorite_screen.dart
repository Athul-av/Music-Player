import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/controller/get_all_song_controller.dart';
import 'package:music_app/db/functions/favorite_db.dart';
import 'package:music_app/db/functions/recent_db.dart';
import 'package:music_app/screens/musicplayingscreen/music_playing_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override 
  Widget build(BuildContext context) {
   return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter, 
          colors: [
           Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0) 
          ],
        ),
      ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Favorite',
            style: TextStyle(
                                 fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 15, 159, 167),
                                fontSize: 26,    
                              ),),
            centerTitle: true,
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: FavoriteDb.favoriteSongs,
                    builder: (BuildContext ctx, List<SongModel> favoriteData,
                        Widget? child) {
                      if (favoriteData.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 70, left: 10),
                          child: Center(
                            child: Column(
                              children: [
                               SizedBox(height: MediaQuery.of(context).size.height*0.18,), 
                               const Text(
                                  'No Favorite Songs',
                                    style: TextStyle(
                                 fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18,   
                              ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else { 
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: favoriteData.length,
                          itemBuilder: (ctx, index) {
                            return ListTile(
                               tileColor: Color.fromARGB(255, 12, 12, 12), 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minVerticalPadding: 10.0,
                            
                              contentPadding: const EdgeInsets.all(0),
                              onTap: () {
                                List<SongModel> favoriteList = [
                                 ...favoriteData
                                ];
                                // GetAllSongController.audioPlayer.stop();
                                GetAllSongController.audioPlayer.setAudioSource(
                                    GetAllSongController.createSongList(
                                        favoriteList),
                                    initialIndex: index);
                                GetAllSongController.audioPlayer.play();
                                GetRecentSong.addRecentlyPlayed(
                                    favoriteList[index].id);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => MusicPlayingScreen(
                                      songModelList: favoriteList,
                                    ),
                                  ),
                                );
                              },
                              leading: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: QueryArtworkWidget(
                                  id: favoriteData[index].id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: const Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5), 
                                    child: Icon(Icons.music_note,color: Colors.white,size: 33,), 
                                  ),
                                ),
                              ),
                              title: Text(
                                favoriteData[index].displayNameWOExt,
                                maxLines: 1,
                                 style: const TextStyle(
                                 fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18,   
                              ),  
                              ),
                              subtitle: Text(
                                favoriteData[index].artist.toString(),
                                maxLines: 1,
                                style: const TextStyle(
                                 fontFamily: 'UbuntuCondensed',
                                 color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 11,   
                              ),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    FavoriteDb.favoriteSongs.notifyListeners();
                                    FavoriteDb.delete(favoriteData[index].id);
                                    const snackbar = SnackBar(
                                      backgroundColor: Colors.black,
                                      content: Text(
                                        'Song deleted from your favorites',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      duration: Duration(
                                        seconds: 1,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            );
                          },
                          separatorBuilder: (BuildContext context, index) {
                            return const Divider(
                              height: 10.0,
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )  
       );
   
  }
 }

