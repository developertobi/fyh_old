import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  final bool isCorrect;

  const Status({
    @required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        isCorrect ? 'Correct' : 'Pass',
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
