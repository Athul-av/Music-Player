import 'package:flutter/material.dart';
import 'package:music_app/db/functions/favorite_db.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavButMusicPlaying extends StatefulWidget {
  const FavButMusicPlaying({super.key, required this.songFavoriteMusicPlaying});
  final SongModel songFavoriteMusicPlaying;


  @override
  State<FavButMusicPlaying> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavButMusicPlaying> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: FavoriteDb.favoriteSongs,
        builder: (BuildContext ctx, List<SongModel> favoriteData, Widget? child) {
          return IconButton(
            onPressed: () {
              if (FavoriteDb.isFavor(widget.songFavoriteMusicPlaying)) {
                FavoriteDb.delete(widget.songFavoriteMusicPlaying.id);
                const snackBar = SnackBar(
                  backgroundColor: Colors.black, 
                  content: Text(
                    'Removed From Favorite',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(milliseconds: 350), 
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                FavoriteDb.add(widget.songFavoriteMusicPlaying);
                const snackbar = SnackBar(
                  backgroundColor: Colors.black,
                  content: Text(
                    'Song Added to Favorite',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(milliseconds: 350),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }

              FavoriteDb.favoriteSongs.notifyListeners();
            },
            icon: FavoriteDb.isFavor(widget.songFavoriteMusicPlaying)
                ? Icon(
                    Icons.favorite,
                    color: Colors.red[600],
                  )
                : const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
          );
        });
  }
}