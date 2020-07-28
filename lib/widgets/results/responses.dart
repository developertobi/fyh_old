import 'package:flutter/material.dart';
import 'package:naija_charades/constants.dart';
import 'package:naija_charades/models/response.dart';

class Responses extends StatelessWidget {
  const Responses({@required this.responses});
  final List<Response> responses;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: responses
            .map((response) => Text(
                  response.word,
                  textAlign: TextAlign.center,
                  style: kNunitoTextStyle.copyWith(
                    fontSize: 20,
                    color: response.isCorrect ? Colors.black : Colors.black26,
                    decoration: response.isCorrect
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
                  ),

                  // style: TextStyle(
                  //   color: response.isCorrect ? Colors.black : Colors.black26,
                  //   fontSize: 20,
                  //   decoration: response.isCorrect
                  //       ? TextDecoration.none
                  //       : TextDecoration.lineThrough,
                  // ),
                ))
            .toList(),
      ),
    );
  }
}
