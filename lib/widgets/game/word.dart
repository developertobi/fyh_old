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
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 10,
          child: Text(
            '0:$timeLeft',
            style: TextStyle(
                fontSize: isLast5Seconds ? 50 : 24, color: Colors.white),
          ),
        ),
        Text(
          answer,
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
