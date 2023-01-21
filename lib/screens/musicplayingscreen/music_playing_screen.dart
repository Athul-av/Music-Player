import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/controller/get_all_song_controller.dart';
import 'package:music_app/db/functions/favorite_db.dart';
import 'package:music_app/db/functions/mostlyplayed.dart';
import 'package:music_app/db/functions/recent_db.dart';
import 'package:music_app/providers/NowPlayingProvdr.dart';
import 'package:music_app/screens/favoritescreen/favbut_musicplaying.dart';
import 'package:music_app/screens/homescreen/allsongs/playlistscreen.dart';
import 'package:music_app/screens/miniplayer/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MusicPlayingScreen extends StatelessWidget {
   MusicPlayingScreen({
    super.key,
    required this.songModelList,
  });
  final List<SongModel> songModelList;
  bool _isShuffle = false; 

  @override
  Widget build(BuildContext context) {
    final nowplayprovdr = Provider.of<NowPlayingProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NowPlayingProvider>(context,listen: false).indexchange();
    },);
    Provider.of<NowPlayingProvider>(context,listen: false).playSong();
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<NowPlayingProvider>(
              builder: (context, value, child) {
               return SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                         
                          Navigator.of(context).pop();

                          FavoriteDb.favoriteSongs.notifyListeners();
                
                        },
                        icon: const Icon(Icons.keyboard_arrow_down),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/11,),    
                     ClipRRect(
                      child: SizedBox(  
                          width: MediaQuery.of(context).size.height * 0.32, 
                          height: MediaQuery.of(context).size.width* 0.55,  
                          child: QueryArtworkWidget(id: songModelList[nowplayprovdr.currentIndex].id,
                          
                          type: ArtworkType.AUDIO,
                          keepOldArtwork: true,
                          nullArtworkWidget: Image.asset('assets/images/music logo2-modified (1).png'),)  
                          ), 
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                         Padding(
                      padding: const EdgeInsets.only(left:20 ,right: 12), 
                      child: Text(
                        songModelList[nowplayprovdr.currentIndex].displayNameWOExt,
                        overflow: TextOverflow.ellipsis,
                         style: const TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 23,
                   
                   ), 
                      ),
                    ),
                        const SizedBox(
                          height: 13,
                        ),
                         Text(
                      songModelList[nowplayprovdr.currentIndex].artist.toString() == "<unknown>"
                          ? "Unknown artist" : songModelList[nowplayprovdr.currentIndex].artist.toString(),
                      overflow: TextOverflow.ellipsis,
                      style:const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                        const SizedBox(
                          height: 24,   
                        ),
                         Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                GetAllSongController.audioPlayer.loopMode ==
                                        LoopMode.one
                                    ? GetAllSongController.audioPlayer
                                        .setLoopMode(LoopMode.all)
                                    : GetAllSongController.audioPlayer
                                        .setLoopMode(LoopMode.one);  
                              },
                              icon: StreamBuilder<LoopMode>(
                                stream: GetAllSongController
                                    .audioPlayer.loopModeStream,
                                builder: (context, snapshot) {
                                  final loopMode = snapshot.data;
                                  if (LoopMode.one == loopMode) { 
                                    return Icon(
                                      Icons.repeat, 
                                      color: Colors.red[600],
                                    );
                                  } else {
                                    return const Icon(
                                      Icons.repeat,
                                      color: Colors.white,
                                    );
                                  }
                                },
                              ),
                            ),
                          IconButton(
                              onPressed: () {
                                _isShuffle == false
                                    ? GetAllSongController.audioPlayer
                                        .setShuffleModeEnabled(true)
                                    : GetAllSongController.audioPlayer
                                        .setShuffleModeEnabled(false);
                              },
                              icon: StreamBuilder<bool>(
                                stream: GetAllSongController
                                    .audioPlayer.shuffleModeEnabledStream,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  _isShuffle = snapshot.data;
                                  if (_isShuffle) {
                                    return Icon(
                                      Icons.shuffle,
                                      color: Colors.red[600],
                                    );
                                  } else {
                                    return const Icon(
                                      Icons.shuffle,   
                                      color: Colors.white,
                                    );
                                  }
                                },
                              ),
                          ),
                          IconButton(
                            onPressed: () { 
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=> PlaylistScreenFromallsong(findex:nowplayprovdr. currentIndex,)));
                            },
                            icon:const Icon(Icons.playlist_add), 
                            color: Colors.white,
                          ),
                           FavButMusicPlaying(
                          songFavoriteMusicPlaying:
                         songModelList[nowplayprovdr.currentIndex]),
                        ],
                      ), 
                      SizedBox(height: MediaQuery.of(context).size.height*0.075,),   
                        Row(
                          children: [
                            Text(
                              nowplayprovdr.position.toString().substring(2, 7),
                              style: const TextStyle(color: Colors.white),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Color.fromARGB(255, 15, 159, 167),
                                  thumbShape:const RoundSliderThumbShape( enabledThumbRadius: 8.0),
                                  overlayShape:const RoundSliderOverlayShape(overlayRadius: 2.0),           
                                  trackHeight:3
                                ),
                                child: Slider( 
                                  value: nowplayprovdr.position.inSeconds.toDouble(),
                                  onChanged: ((double value) {
                                   
                                 Provider.of<NowPlayingProvider>(context,listen: false).changeToSeconds(value.toInt());
                                      value = value;
                              
                                  }),
                                  min: 0.0,
                                  max: nowplayprovdr.duration.inSeconds.toDouble(),
                                  inactiveColor: Colors.white.withOpacity(0.5),  
                                  activeColor: const Color.fromARGB(255, 15, 159, 167), 
                                ),
                              ),
                            ),
                            Text(
                              nowplayprovdr.duration.toString().substring(2, 7),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                          children: [ 
                            
                            IconButton(
                                onPressed: () async {
                                  if (GetAllSongController
                                      .audioPlayer.hasPrevious) {
                                    // add to recent
                                     GetRecentSong.addRecentlyPlayed(
                                      songModelList[nowplayprovdr.currentIndex-1].id); 
            
                                    //add to mostly
                                      GetMostlyPlayed.addmostlyPlayed(    
                                        songModelList[nowplayprovdr.currentIndex-1].id);       
                                        
                                    await GetAllSongController.audioPlayer
                                        .seekToPrevious();
                                    await GetAllSongController.audioPlayer.play();
                                  } else {
                                    await GetAllSongController.audioPlayer.play();
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_previous ,
                                  size: 38,
                                  color: Colors.white,
                                )),
                                 IconButton(onPressed: (){
                              if(GetAllSongController.audioPlayer.position.inSeconds>10){ 
                           GetAllSongController.audioPlayer.seek(Duration(seconds:GetAllSongController.audioPlayer.position.inSeconds -10));   
                              } else{
                               GetAllSongController.audioPlayer .seek(Duration(seconds: 0)); 
                              }   
                            }, 
                            icon:const Icon(Icons.replay_10,color: Colors.white,)),  
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 0, 0, 0), 
                                  shape: const CircleBorder()),
                              onPressed: () async {
                                if (GetAllSongController.audioPlayer.playing) {
                                
                                  await GetAllSongController.audioPlayer.pause();
                                } else {
                                  await GetAllSongController.audioPlayer.play();
                                   
                                }  
                              },
                              child: StreamBuilder<bool>(
                                stream: GetAllSongController
                                    .audioPlayer.playingStream,
                                builder: (context, snapshot) {
                                  bool? playingStage = snapshot.data;
                                  if (playingStage != null && playingStage) {
                                    return const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Icon(
                                        Icons.pause_circle_outline, 
                                        color: Color.fromARGB(255, 15, 159, 167), 
                                        size: 78, 
                                      ),
                                    );
                                  } else {
                                    return const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        color:  Color.fromARGB(255, 15, 159, 167),  
                                        size: 78 , 
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                             IconButton(onPressed: (){
                             if (GetAllSongController.audioPlayer.position.inSeconds+10 > GetAllSongController.audioPlayer.duration!.inSeconds){
                             GetAllSongController.audioPlayer.seek(Duration(seconds:GetAllSongController.audioPlayer.duration!.inSeconds ));
                              }else{ 
                                GetAllSongController.audioPlayer.seek(Duration(seconds:GetAllSongController.audioPlayer.position.inSeconds +10)); 
                              }   
                            }, icon:const Icon(Icons.forward_10,color: Colors.white,)),
                            IconButton(
                                onPressed: () async {
                                  if (GetAllSongController.audioPlayer.hasNext) {
                                     //add recent
                                    GetRecentSong.addRecentlyPlayed(
                                      songModelList[Provider.of<NowPlayingProvider>(context,listen: false).currentIndex+1].id); 
                                      // add mostly
                                      GetMostlyPlayed.addmostlyPlayed(    
                                        songModelList[Provider.of<NowPlayingProvider>(context,listen: false).currentIndex+1].id);     
                                    await GetAllSongController.audioPlayer
                                        .seekToNext();
                                    await GetAllSongController.audioPlayer.play();
                                     
                                  } else {
                                    await GetAllSongController.audioPlayer.play();
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_next,
                                  size: 38,
                                  color: Colors.white,
                                )),
                           
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
              },
         
            ),
          ),
        ),
      ),
    );
  }
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController playlistController = TextEditingController();
