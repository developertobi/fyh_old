import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/providers/answers.dart';
import 'package:naija_charades/screens/game_screen.dart';
import 'package:naija_charades/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'results_bottom_sheet.dart';

class TimeUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleAnimatedTextKit(
        scalingFactor: 1.5,
        text: ['Time UP'],
        totalRepeatCount: 1,
        textStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 70),
        onFinished: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);

          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ResultsBottomSheet();
            },
          ).then(
            (_) => Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routeName),
          );
        },
      ),
    );
  }
}
