import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/screens/homescreen/allsongs/allsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GetMostlyPlayed {
  static ValueNotifier<List<SongModel>> mostlyPlayedNotifier = ValueNotifier([]);
  static List<dynamic> mostlyPlayed = [];

  static Future<void> addmostlyPlayed(item) async {
    final mostplayedDb = await Hive.openBox('mostlyPlayedNotifier');
    await mostplayedDb.add(item);
   
    mostlyPlayedNotifier.notifyListeners();
  }

  

  static Future<void> getMostlyPlayedSongs() async {
    final mostplayedDb = await Hive.openBox('mostlyPlayedNotifier');
    // ignore: non_constant_identifier_names
    final MostlyPlayedSongItems = mostplayedDb.values.toList();
    mostlyPlayedNotifier.value.clear();
    int count=0; 
    // for (int i = 0; i < MostlyPlayedSongItems.length;i++) {
    //   for (int j = 0; j < startSong.length; j++) {
    //     if (MostlyPlayedSongItems[i] == startSong[j].id) {
    //       mostlyPlayedNotifier.value.add(startSong[j]); 
    //     }
    //   }
    // }
   for(int i= 0;i< MostlyPlayedSongItems.length ; i++){
    for(int j=0;j< MostlyPlayedSongItems.length ; j++){
      if(MostlyPlayedSongItems[i]==MostlyPlayedSongItems[j]){
        count++;
      }
    }
    if(count>2){  
        for(int k=0; k< startSong.length ; k++){
          if(MostlyPlayedSongItems[i]==startSong[k].id){
            mostlyPlayedNotifier.value.add(startSong[k]); 
          }
        }
        count=0; 
      } 
   } 
  } 
}