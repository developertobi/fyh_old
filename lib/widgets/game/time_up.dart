import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/screens/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class TimeUp extends StatelessWidget {
  final Map<String, PermissionStatus> statuses;

  const TimeUp(this.statuses);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleAnimatedTextKit(
        scalingFactor: 1.5,
        text: ['Time UP'],
        totalRepeatCount: 1,
        textStyle: TextStyle(
          fontSize: 70,
          color: Colors.white,
          fontWeight: FontWeight.bold,
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

          // showModalBottomSheet(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return ResultsBottomSheet(
          //       showVideo: statuses['camera'].isGranted &&
          //           statuses['microphone'].isGranted,
          //     );
          //   },
          // ).then((_) =>
          //     Navigator.of(context).pushReplacementNamed(HomeScreen.routeName));
        },
      ),
    );
  }
}
