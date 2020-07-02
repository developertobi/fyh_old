import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naija_charades/providers/responses.dart';
import 'package:naija_charades/providers/words.dart';
import 'package:naija_charades/screens/game_screen.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main() => runApp(NaijaCharadesApp());

class NaijaCharadesApp extends StatelessWidget {
  final _textStyle = TextStyle(
    fontWeight: FontWeight.w600,
    letterSpacing: -1,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Words()),
        Provider(create: (_) => Responses()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Naija Charades',
        theme: ThemeData(
          textTheme: GoogleFonts.ptSerifTextTheme(Theme.of(context).textTheme)
              .copyWith(
            bodyText2: _textStyle,
            bodyText1: _textStyle,
            button: _textStyle,
          ),
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => HomeScreen(),
          GameScreen.routeName: (_) => GameScreen(),
        },
      ),
    );
  }
}
