
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/controller/get_all_song_controller.dart';
import 'package:music_app/db/functions/recent_db.dart';
import 'package:music_app/screens/musicplayingscreen/music_playing_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

late List<SongModel> allSong;
List<SongModel> foundSongs = [];
final audioPlayer = AudioPlayer();
final audiQuery = OnAudioQuery();

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    songsLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        
        body: Column(
          children: [
            Expanded(
              child: Container(
                color:  Color.fromARGB(255, 0, 0, 0), 
                child: SafeArea(
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop(); 
                      }, icon:const Icon(Icons.arrow_back),color: Colors.white,),
                     
                    SizedBox(
                      height: 50,
                      width: 300,  
                      child: CupertinoSearchTextField(
                        borderRadius: BorderRadius.all(Radius.circular(25)),  
                         style: const TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                   
                   ),
                        prefixIcon: const 
                               Icon(
                                Icons.search,
                              ), 
                            backgroundColor: Colors.white, 
                            
                            onChanged: (value) => search(value),
                      ))
                    ],
                  ),
                ),
              )),
            Expanded(
              flex: 6,
              child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15,2,15,2), 
                    child: SafeArea(
                      child: Column(
                        children: [
                          
                          foundSongs.isNotEmpty
                              ? ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
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
                                          id: foundSongs[index].id,
                                          type: ArtworkType.AUDIO,
                                          nullArtworkWidget: const Padding(
                                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                            child: Icon(Icons.music_note,color: Colors.white,size: 33,),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        foundSongs[index].title,
                                        maxLines: 1,
                                        style: const TextStyle(
                             fontFamily: 'UbuntuCondensed',
                              color: Color.fromARGB(255, 255, 255, 255),
                             fontSize: 18,  
                             ), 
                                      ),
                                      subtitle: Text(
                                        '${foundSongs[index].artist == "<unknown>" ? "Unknown Artist" : foundSongs[index].artist}',
                                        maxLines: 1,
                                         style: const TextStyle(
                    fontFamily: 'UbuntuCondensed',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 11,
                   
                   ),
                                      ),
                                      onTap: () {
                                        GetAllSongController.audioPlayer.setAudioSource(
                                            GetAllSongController.createSongList(
                                              foundSongs,
                                            ),
                                            initialIndex: index); 
                                        GetAllSongController.audioPlayer.play();
                                        GetRecentSong.addRecentlyPlayed(
                                            foundSongs[index].id); 
                                        Navigator.push(context,  
                                            MaterialPageRoute(builder: (context) {
                                          return MusicPlayingScreen(
                                            songModelList: foundSongs,
                                          );
                                        })); 
                                      },
                                    );
                                  },
                                  itemCount: foundSongs.length,
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      height: 10.0,
                                    );
                                  },
                                )
                              : const Center(
                                  child:Text('No songs available',style: TextStyle(color: Colors.white),)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ); 
  }

  void songsLoading() async {
    allSong = await audiQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    foundSongs = allSong;
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
    setState(() {
      foundSongs = results;
    });
  }
}