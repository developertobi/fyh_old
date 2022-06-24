import 'package:flutter/material.dart';
import 'package:naija_charades/constants.dart';

class Word extends StatelessWidget {
  final String answer;

  final String timeLeft;
  final bool isLast5Seconds;

  const Word({
    required this.answer,
    required this.timeLeft,
    this.isLast5Seconds = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 10,
          child: Text(
            '0:$timeLeft',
            style:
                kNunitoTextStyle.copyWith(fontSize: isLast5Seconds ? 50 : 24),
          ),
        ),
        Text(
          answer,
          style: kNunitoTextStyle.copyWith(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
