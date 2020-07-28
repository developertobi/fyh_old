import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:naija_charades/constants.dart';

class ReadyTimer extends StatelessWidget {
  final Function onReady;

  const ReadyTimer({@required this.onReady});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: RotateAnimatedTextKit(
        onFinished: onReady,
        totalRepeatCount: 1,
        textStyle: kNunitoTextStyle.copyWith(fontSize: 70),
        // textStyle: TextStyle(fontSize: 70, color: Colors.white),
        text: ['3', '2', '1', 'GO'],
        textAlign: TextAlign.center,
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}
