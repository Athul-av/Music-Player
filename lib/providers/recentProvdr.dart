import 'package:flutter/cupertino.dart';
import 'package:music_app/db/functions/recent_db.dart';

class RecentProvider with ChangeNotifier{
    allrecentsong() async {
    await GetRecentSong.getRecentSong();  
    notifyListeners();
  }
}