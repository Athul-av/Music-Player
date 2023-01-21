import 'package:flutter/cupertino.dart';
import 'package:music_app/db/functions/mostlyplayed.dart';

class mostlyplayedProvider with ChangeNotifier{

    allmostlyplayedsong() async {
    await GetMostlyPlayed.getMostlyPlayedSongs();  
    notifyListeners();
  }
}