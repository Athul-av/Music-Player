import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/db/functions/favorite_db.dart';
import 'package:music_app/db/model/muzic_model.dart';
import 'package:music_app/screens/splashscreen/splash_screen.dart';


class PlaylistDb {
  static ValueNotifier<List<MuzicModel>> playlistNotifier = ValueNotifier([]);
  static final playlistDb = Hive.box<MuzicModel>('playlistDb');

  static Future<void> addPlaylist(MuzicModel value) async {
    final playlistDb = Hive.box<MuzicModel>('playlistDb');
    await playlistDb.add(value);
    playlistNotifier.value.add(value);
  }
 
  static Future<void> getAllPlaylist() async {
    final playlistDb = Hive.box<MuzicModel>('playlistDb');
    playlistNotifier.value.clear();
    playlistNotifier.value.addAll(playlistDb.values);
    playlistNotifier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    final playlistDb = Hive.box<MuzicModel>('playlistDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }
  static Future<void> editList(int index, MuzicModel value) async {
    final playlistDb = Hive.box<MuzicModel>('playlistDb');
    await playlistDb.putAt(index, value); 
     getAllPlaylist();
  }


  static Future<void>  resetAPP(context) async {
    final playListDb = Hive.box<MuzicModel>('playlistDb');
    final musicDb = Hive.box<int>('FavoriteDB'); 
    final recentDb = Hive.box('recentSongNotifier');
    final mostdb=Hive.box('mostlyPlayedNotifier');
    await musicDb.clear();
    await playListDb.clear();
    await recentDb.clear();
    await mostdb.clear(); 
    
    

    FavoriteDb.favoriteSongs.value.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
         (route) => false
        );
  }
}
