import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/db/model/muzic_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistProvider with ChangeNotifier{
   List<SongModel> allSong=[];
   List<SongModel> playlistsong=[];
 final audioPlayer = AudioPlayer();
final audiQuery = OnAudioQuery();
bool valuein=false;

void songsLoading() async {
   allSong = await audiQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    notifyListeners();
  }

 
  
  
void addsong(data)async{
 playlistsong.add(data);
 notifyListeners();
}
 
}