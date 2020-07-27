import 'package:flutter/material.dart';
import 'package:naija_charades/models/response.dart';

class Responses extends StatelessWidget {
  const Responses({@required this.responses});
  final List<Response> responses;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      //   border: Border.all(color: Colors.black26),
      // ),
      child: Column(
        children: responses
            .map((response) => Text(
                  response.word,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: response.isCorrect ? Colors.black : Colors.black26,
                    fontSize: 20,
                    decoration: response.isCorrect
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
                  ),
                ))
            .toList(),
      ),

      // child: ListView.builder(
      //   itemCount: responses.length,
      //   itemBuilder: (context, i) {
      //     var response = responses[i];
      //     return Text(
      //       response.word,
      //       textAlign: TextAlign.center,
      //       style: TextStyle(
      //         color: response.isCorrect ? Colors.black : Colors.black26,
      //         fontSize: 20,
      //         decoration: response.isCorrect
      //             ? TextDecoration.none
      //             : TextDecoration.lineThrough,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
