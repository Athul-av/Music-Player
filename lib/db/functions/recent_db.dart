import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/screens/homescreen/allsongs/allsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GetRecentSong {
  static ValueNotifier<List<SongModel>> recentSongNotifier = ValueNotifier([]);
  static List<dynamic> recentlyPlayed = [];
   

  static Future<void> addRecentlyPlayed(item) async {
    final recentDb = await Hive.openBox('recentSongNotifier');
    await recentDb.add(item);
   
    recentSongNotifier.notifyListeners();
  }

  

  static Future<void> getRecentSong() async {
    final recentDb = await Hive.openBox('recentSongNotifier');
    final recentSongItems = recentDb.values.toList();
    recentSongNotifier.value.clear();

  
    for (int i = 0; i < recentSongItems.length;i++) {
      for (int j = 0; j < startSong.length; j++) {
        if (recentSongItems[i] == startSong[j].id) {
          recentSongNotifier.value.add(startSong[j]);
   
        }
      }
    }
    recentSongNotifier.notifyListeners();
  }
}
