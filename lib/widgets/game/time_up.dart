import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/constants.dart';
import 'package:naija_charades/screens/home_screen.dart';

class TimeUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleAnimatedTextKit(
        scalingFactor: 1.5,
        text: ['TIME UP'],
        totalRepeatCount: 1,
        textStyle: kNunitoTextStyle.copyWith(
          fontSize: 70,
          fontWeight: FontWeight.w900,
        ),
        onFinished: () {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);

          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
            arguments: {
              'results': "",
            },
          );
        },
      ),
    );
  }
}
