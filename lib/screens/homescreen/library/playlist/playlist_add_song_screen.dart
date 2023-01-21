import 'package:flutter/material.dart';
import 'package:music_app/db/functions/playlist_db.dart';
import 'package:music_app/db/model/muzic_model.dart';
import 'package:music_app/providers/playlistProvider/playlistAddprovdr.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SongListPage extends StatefulWidget {
  const SongListPage({super.key, required this.playlist});
  final MuzicModel playlist;

  @override
  State<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
 
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0)
          ], 
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(15,5,15,1), 
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     const Text(
                      'Add Songs',
                      style: TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 15, 159, 167),
                    fontSize: 22,
                   
                   ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white, 
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<SongModel>>(
                  future: audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true,
                  ),
                  builder: (context,item) {
                    if (item.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (item.data!.isEmpty) {
                      return const Center(
                          child: Text(
                        'No Songs Available',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ));
                    }
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index) {
                        return ListTile(
                           tileColor: Color.fromARGB(255, 12, 12, 12), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minVerticalPadding: 10.0,
                          
                          contentPadding: const EdgeInsets.all(0),
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: QueryArtworkWidget(
                              id: item.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Padding(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                child: Icon(Icons.music_note,color: Colors.white,size: 32,),
                              ),
                            ),
                          ),
                          title: Text(
                            item.data![index].displayNameWOExt,
                            maxLines: 1,
                             style: const TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18,
                    
                   ),
                          ),
                          subtitle: Text(
                            '${item.data![index].artist == "<unknown>" ? "Unknown Artist" 
                            : item.data![index].artist}',
                            maxLines: 1,
                              style: const TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 11,
                    
                   ),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Consumer<PlaylistProvider>(
                              builder: (context, value, child) {
                               return Wrap(
                                children: [
                                  !widget.playlist.isValueIn(item.data![index].id)
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              songAddToPlaylist(
                                                 item.data![index]);
                                              PlaylistDb.playlistNotifier
                                               .notifyListeners();
                                             });
                                          },
                                          icon: const Icon(Icons.add,color: Colors.white,),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              widget.playlist.deleteData(
                                                  item.data![index].id);
                                            });
                                            const snackBar = SnackBar(
                                              backgroundColor: Colors.black,
                                              content: Text(
                                                'Song deleted from playlist',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 450),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          icon: const Padding(
                                            padding: EdgeInsets.only(bottom: 25),
                                            child: Icon(Icons.minimize,color: Colors.white,),
                                       ),
                                   ),
                                ],
                              );
                              },
                             
                            ),
                          ),
                        );
                      },
                      itemCount: item.data!.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 10.0,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }


  void songAddToPlaylist(SongModel data) {
   
      widget.playlist.add(data.id);
      const snackbar1 = SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Song added to Playlist',
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar1);
   
  }
}
