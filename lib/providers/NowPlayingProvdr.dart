import 'package:flutter/cupertino.dart';
import 'package:music_app/controller/get_all_song_controller.dart';

class NowPlayingProvider with ChangeNotifier{

Duration duration = const Duration();
  Duration position = const Duration();

  bool _isShuffle = false; 
  int currentIndex = 0;
  int counter = 0;

  void playSong() {
    GetAllSongController.audioPlayer.durationStream.listen((eventd) {
      
        duration = eventd!;
        notifyListeners();
    });
    GetAllSongController.audioPlayer.positionStream.listen((eventp) {
  
        position = eventp;
    notifyListeners();
    });
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
  }

void indexchange(){
  GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        
          currentIndex = index;
    
        GetAllSongController.currentIndexes = index;
        notifyListeners();
      }
    });
}
}