import 'package:flutter/material.dart';

class Word extends StatelessWidget {
  final String answer;

  final String timeLeft;
  final bool isLast5Seconds;

  const Word({
    @required this.answer,
    @required this.timeLeft,
    this.isLast5Seconds = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          answer,
          style: TextStyle(fontSize: 50, color: Colors.white),
        ),
        SizedBox(height: 50),
        Text(
          '0:$timeLeft',
          style: TextStyle(
              fontSize: isLast5Seconds ? 50 : 24, color: Colors.white),
        ),
      ],
    );
  }
}
