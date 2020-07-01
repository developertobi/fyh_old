import 'package:flutter/material.dart';

class Word extends StatelessWidget {
  final String answer;
  final int timeLeft;
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
          style: TextStyle(fontSize: 50),
        ),
        SizedBox(height: 10),
        Text(
          timeLeft.toString(),
          style: TextStyle(fontSize: isLast5Seconds ? 50 : 24),
        ),
        // !isLast5Seconds
        //     ? Text(
        //         timeLeft.toString(),
        //         style: TextStyle(fontSize: 24),
        //       )
        //     : ScaleAnimatedTextKit(
        //         text: [timeLeft.toString()],
        //         isRepeatingAnimation: false,
        //         textStyle: Theme.of(context)
        //             .textTheme
        //             .bodyText1
        //             .copyWith(fontSize: 24),
        //       )
      ],
    );
  }
}
