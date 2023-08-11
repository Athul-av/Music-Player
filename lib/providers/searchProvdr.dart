import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchProvider with ChangeNotifier{
late List<SongModel> allSong;
 List<SongModel> foundSongs = [];
final audiQuery = OnAudioQuery();
 
  void songsLoading() async {
   allSong = await audiQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    foundSongs = allSong;
    notifyListeners();
  }

  void search(String enteredKeyword) {
    List<SongModel> results = [];
    
    if (enteredKeyword.isEmpty) {
      results = allSong;
    } else {
      results = allSong
          .where((element) => element.title 
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    
      foundSongs = results;
    notifyListeners();
  }
}