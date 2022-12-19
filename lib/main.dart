import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/db/model/muzic_model.dart';
import 'package:music_app/screens/splashscreen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(MuzicModelAdapter().typeId)) {
    Hive.registerAdapter(MuzicModelAdapter());
  }

  await Hive.initFlutter();

  await Hive.openBox<MuzicModel>('playlistDb');
  await Hive.openBox<int>('FavoriteDB'); 
  await Hive.openBox('recentSongNotifier'); 
  await Hive.openBox('mostlyPlayedNotifier'); 


  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paattu player',
      theme: ThemeData(
        primarySwatch: Colors.teal, 
      ),
      home: const SplashScreen(),
    );
  }
}
