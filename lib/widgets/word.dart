import 'package:flutter/material.dart';
import 'package:naija_charades/widgets/round_button.dart';

class Word extends StatelessWidget {
  final String answer;
  final String score;
  final int timeLeft;
  final bool isLast5Seconds;

  const Word({
    @required this.answer,
    @required this.score,
    @required this.timeLeft,
    this.isLast5Seconds = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RoundButton(
          buttonText: score,
          width: 80,
        ),
        Text(
          answer,
          style: TextStyle(fontSize: 50),
        ),
        SizedBox(height: 10),
        Text(
          timeLeft.toString(),
          style: TextStyle(fontSize: isLast5Seconds ? 50 : 24),
        ),
      ],
    );
  }
}
