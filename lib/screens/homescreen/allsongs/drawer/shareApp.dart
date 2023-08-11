import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


Widget ShareAppFile(BuildContext context) {
  return Scaffold(
    body: FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 30), () {
        return Share.share('https://play.google.com/store/apps/details?id=in.music.Paattu_Player');
      }),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.data;
      },
    ), 
  );
}