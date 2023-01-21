import 'package:flutter/material.dart';
import 'package:music_app/controller/get_all_song_controller.dart';
import 'package:music_app/db/functions/favorite_db.dart';
import 'package:music_app/db/functions/mostlyplayed.dart';
import 'package:music_app/db/functions/recent_db.dart';
import 'package:music_app/providers/allSongsProvider.dart';
import 'package:music_app/screens/homescreen/allsongs/drawer/drawers.dart';
import 'package:music_app/screens/homescreen/allsongs/more.dart';
import 'package:music_app/screens/homescreen/allsongs/searchscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../musicplayingscreen/music_playing_screen.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) { 
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       Provider.of<AllsongProvider>(context,listen: false).requestPermission();
    },);
    return Consumer<AllsongProvider>(
      builder: (context, value, child) {
        return  Container(
          decoration:const BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter, 
            colors: [
              Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 0, 0, 0)  
            ],
          ), ),  
        child: Scaffold(
          resizeToAvoidBottomInset: false, 
          backgroundColor: Colors.transparent,
          drawer:const Drawer(
               child:HomescreenDrawers()
          ),
         
           body: NestedScrollView(
          headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                SliverAppBar(
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  elevation: 0, 
                  expandedHeight: MediaQuery.of(context).size.height * 0.2,
                  
                  flexibleSpace:  const FlexibleSpaceBar(
                    centerTitle: true,
                    
                    title: Text(
                      'PAATTU PLAYER', 
                     style: TextStyle(
                      fontFamily: 'UbuntuCondensed',
                      color: Color.fromARGB(255, 15, 159, 167),
                      fontSize: 25,
                      fontWeight: FontWeight.w600
                     ),
                      textAlign: TextAlign.start,
                    ), 
                  ),
                 
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const SearchScreen();
                            },
                          ));
                        },
                        icon: const Icon(
                          Icons.search,
                        )
                        )
                  ],
                )
              ]),
          body: SafeArea( 
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [      
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<List<SongModel>>(
                      future: _audioQuery.querySongs(
                        sortType: null,
                        orderType: OrderType.ASC_OR_SMALLER,
                        uriType: UriType.EXTERNAL,
                        ignoreCase: true,
                      ),
                      builder: (context, item) {
                        if (item.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (item.data!.isEmpty) {
                          return  const Padding(
                            padding:
                           EdgeInsets.symmetric(vertical: 200, horizontal: 100),
                            child: Text(
                              'No Songs Available',
                              style: TextStyle(
                      fontFamily: 'UbuntuCondensed',
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 19, 
                      
                     ),
                            ),
                          );
                        }
                        startSong = item.data!;
                        if (!FavoriteDb.isInitialized) {
                          FavoriteDb.intialize(item.data!);
                        }  
          
                        GetAllSongController.songscopy = item.data!;
          
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            
                            return ValueListenableBuilder(
                              valueListenable:
                                  GetRecentSong.recentSongNotifier,
                              builder: (BuildContext context, List<SongModel> value,
                                  Widget? child) { 
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
                                        child: Icon(Icons.music_note,color: Colors.white,size: 33,), 
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
                                    '${item.data![index].artist == "<unknown>" ? "Unknown Artist" : item.data![index].artist}',
                                    maxLines: 1,
                                    style: const TextStyle(
                                   fontFamily: 'UbuntuCondensed',
                                   color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 11,   
                                ),
                                  ),
                                  trailing: Wrap(
                                    children: [
                                      IconButton(  
                                        onPressed: () {
                                          moredialog(context,index);  
                                        },
                                        icon: const Icon(Icons.more_vert,color: Colors.white,), 
                                      ),     
                                    ],
                                  ),
                                  onTap: () {          
                                    GetAllSongController.audioPlayer.setAudioSource(
                                        GetAllSongController.createSongList(
                                         item.data!,
                                        ),
                                        initialIndex: index);
          
                                    GetAllSongController.audioPlayer.play();
                                    //recent song function 
                                    GetRecentSong.addRecentlyPlayed(
                                        item.data![index].id);  
    
                                     //mostly played 
                                         GetMostlyPlayed.addmostlyPlayed(    
                                          item.data![index].id);  
                                        
                                    //for navigating to nowplay
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MusicPlayingScreen(
                                        songModelList: item.data!,
                                      );
                                    }));
                                  },
                                );
                              },);
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
            ),
          ),
          
        ), 
      )
      );
      },
      
    ); 
  }
}
List<SongModel> startSong = [];