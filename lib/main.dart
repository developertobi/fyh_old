/// -----------------------------------------------------------------
/// 
/// File: main.dart
/// Project: Official Cali Connect
/// File Created: Monday, June 29th, 2020
/// Description: 
/// 
/// Author: Timothy Itodo - timothy@longsoftware.io
/// -----
/// Last Modified: Sunday, November 8th, 2020
/// Modified By: Timothy Itodo - timothy@longsoftware.io
/// -----
/// 
/// Copyright (C) 2020 - 2020 Long Software LLC. & Official Cali Connect
/// 
/// -----------------------------------------------------------------

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:naija_charades/providers/firestore_data.dart';
import 'package:naija_charades/providers/results.dart';
import 'package:naija_charades/providers/video_file.dart';
import 'package:naija_charades/providers/words.dart';
import 'package:naija_charades/screens/game_screen.dart';

import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(NaijaCharadesApp());
}

class NaijaCharadesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Words()),
        Provider(create: (_) => Results()),
        Provider(create: (_) => VideoFile()),
        Provider(create: (_) => FirestoreData())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Naija Charades',
        initialRoute: HomeScreen.routeName,
        theme: ThemeData.dark(),
        routes: {
          HomeScreen.routeName: (_) => HomeScreen(),
          GameScreen.routeName: (_) => GameScreen(),
        },
      ),
    );
  }
}