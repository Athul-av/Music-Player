import 'package:flutter/cupertino.dart';
import 'package:music_app/controller/get_all_song_controller.dart';

class MiniPlayerProvdr with ChangeNotifier{
 miniplay() async{
   GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null ) {
        notifyListeners();
      }
    });
}

}