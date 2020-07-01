import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Status extends StatelessWidget {
  final bool isCorrect;

  const Status({
    @required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    // changeBackgroundColor(isCorrect);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          isCorrect ? 'Correct' : 'Wrong',
          style: TextStyle(fontSize: 50),
        ),
        SizedBox(height: 20),
        Icon(
          isCorrect ? AntDesign.checkcircleo : AntDesign.closecircleo,
          color: Colors.white,
          size: 70,
        ),
      ],
    );
  }
}
