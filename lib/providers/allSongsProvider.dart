import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AllsongProvider with ChangeNotifier{

    final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> allSongs = [];

   void requestPermission() async {
   
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
    
  
    Permission.storage.request();
     notifyListeners(); 
  }

   void songsLoading() async {
   allSongs = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    
    notifyListeners();
  }

}