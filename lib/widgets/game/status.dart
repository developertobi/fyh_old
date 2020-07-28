import 'package:flutter/material.dart';
import 'package:naija_charades/constants.dart';

class Status extends StatelessWidget {
  final bool isCorrect;

  const Status({
    @required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        isCorrect ? 'CORRECT' : 'PASS',
        style: kNunitoTextStyle.copyWith(
          fontSize: 50,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }
}
