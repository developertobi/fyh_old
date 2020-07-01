import 'dart:math';

import 'package:flutter/material.dart';
import 'package:naija_charades/providers/answers.dart';
import 'package:provider/provider.dart';

class Word extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Answers>(
      builder: (context, answers, child) {
        List words = answers.words;
        int i = Random().nextInt(words.length);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              words[i],
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(height: 10),
            Text(
              '0:59',
              style: TextStyle(fontSize: 24),
            ),
          ],
        );
      },
    );
  }
}
