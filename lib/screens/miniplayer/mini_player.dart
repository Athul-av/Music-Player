import 'package:flutter/material.dart';
import 'package:music_app/controller/get_all_song_controller.dart';
import 'package:music_app/db/functions/mostlyplayed.dart';
import 'package:music_app/db/functions/recent_db.dart';
import 'package:music_app/screens/musicplayingscreen/music_playing_screen.dart';

import 'package:on_audio_query/on_audio_query.dart';


class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color.fromARGB(255, 15, 159, 167),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MusicPlayingScreen(
              songModelList: GetAllSongController.playingSong,
            ),
          ),
        );
      },
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: QueryArtworkWidget(
          id: GetAllSongController
              .playingSong[GetAllSongController.audioPlayer.currentIndex!].id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget: const Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Icon(Icons.music_note,color: Colors.white,size: 30,),
           ),
        ),
      ),
      title: Text(
         GetAllSongController 
            .playingSong[GetAllSongController.audioPlayer.currentIndex!]
            .displayNameWOExt,
            maxLines: 1, 
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      subtitle: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          "${GetAllSongController.playingSong[GetAllSongController.audioPlayer.currentIndex!].artist}",
          maxLines: 1,
          style: const TextStyle(fontSize: 9, overflow: TextOverflow.ellipsis,
          color: Colors.white), 
        ),
      ),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                onPressed: () async {
                  if (GetAllSongController.audioPlayer.hasPrevious) {
                     //add recent
                      GetRecentSong.addRecentlyPlayed(
                    GetAllSongController.playingSong[GetAllSongController.audioPlayer.currentIndex!-1].id); 

                    // add mostly
                        GetMostlyPlayed.addmostlyPlayed(    
                        GetAllSongController.playingSong[GetAllSongController.audioPlayer.currentIndex!-1].id);  

                    await GetAllSongController.audioPlayer.seekToPrevious();
                    await GetAllSongController.audioPlayer.play();
                  } else {
                    await GetAllSongController.audioPlayer.play();
                  }
                },
                icon: const Icon(
                  Icons.skip_previous,
                  size: 35,
                  color: Color.fromARGB(255, 249, 247, 247),
                )),
            IconButton(
         
              onPressed: () async {
                if (GetAllSongController.audioPlayer.playing) {
                  await GetAllSongController.audioPlayer.pause();
                  setState(() {});
                } else {
                  await GetAllSongController.audioPlayer.play();
                  setState(() {});
                }
              },
              icon: StreamBuilder<bool>( 
                stream: GetAllSongController.audioPlayer.playingStream,
                builder: (context, snapshot) {
                  bool? playingStage = snapshot.data;
                  if (playingStage != null && playingStage) {
                    return const Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 40,
                    );
                  } else {
                    return const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 40,  
                    );
                  }
                },
              ),
            ),
            IconButton(
                onPressed: (() async {

                  if (GetAllSongController.audioPlayer.hasNext) {
                     //add recent
                        GetRecentSong.addRecentlyPlayed(
                    GetAllSongController.playingSong[GetAllSongController.audioPlayer.currentIndex!+1].id); 
                    // add mostly
                        GetMostlyPlayed.addmostlyPlayed(    
                        GetAllSongController.playingSong[GetAllSongController.audioPlayer.currentIndex!+1].id); 
                    
                    await GetAllSongController.audioPlayer.seekToNext();
                    await GetAllSongController.audioPlayer.play();
                  } else {
                    await GetAllSongController.audioPlayer.play();
                  }
                }),
                icon: const Icon(
                  Icons.skip_next,
                  size: 35,
                  color: Color.fromARGB(255, 252, 250, 250),
                )),
          ],
        ),
      ),
    );
  }
}
