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