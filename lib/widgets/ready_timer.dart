import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReadyTimer extends StatelessWidget {
  final Function onReady;

  const ReadyTimer({
    @required this.onReady,
  });

  void _setVibration() async {
    int timeLength = 4;

    Timer.periodic(
      Duration(milliseconds: 1600),
      (t) {
        if (timeLength < 1) {
          t.cancel();
        } else {
          HapticFeedback.mediumImpact();
          timeLength -= 1;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _setVibration();

    return FittedBox(
      child: RotateAnimatedTextKit(
        onFinished: onReady,
        totalRepeatCount: 1,
        textStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 70),
        text: ['3', '2', '1', 'GO'],
        textAlign: TextAlign.center,
        duration: Duration(milliseconds: 1500),
      ),
    );
  }
}
