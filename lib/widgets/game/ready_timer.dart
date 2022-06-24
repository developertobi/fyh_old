import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:naija_charades/constants.dart';

class ReadyTimer extends StatelessWidget {
  final void Function()? onReady;

  const ReadyTimer({required this.onReady});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: AnimatedTextKit(
        animatedTexts: [
          RotateAnimatedText(
            '3',
            textAlign: TextAlign.center,
            textStyle: kNunitoTextStyle.copyWith(fontSize: 70),
            duration: const Duration(milliseconds: 200),
          ),
          RotateAnimatedText(
            '2',
            textAlign: TextAlign.center,
            textStyle: kNunitoTextStyle.copyWith(fontSize: 70),
            duration: const Duration(milliseconds: 200),
          ),
          RotateAnimatedText(
            '1',
            textAlign: TextAlign.center,
            textStyle: kNunitoTextStyle.copyWith(fontSize: 70),
            duration: const Duration(milliseconds: 200),
          ),
          RotateAnimatedText(
            'GO',
            textAlign: TextAlign.center,
            textStyle: kNunitoTextStyle.copyWith(fontSize: 70),
            duration: const Duration(milliseconds: 200),
          ),
        ],
        onFinished: onReady,
        totalRepeatCount: 1,
        // isRepeatingAnimation: false,
      ),
    );
  }
}
