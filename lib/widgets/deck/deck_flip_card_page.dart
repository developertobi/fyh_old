import 'package:flutter/material.dart';
import 'package:naija_charades/models/deck.dart';
import 'package:provider/provider.dart';

class DeckFlipCardPage extends StatelessWidget {
  final Widget child;
  const DeckFlipCardPage({@required this.child});

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<Deck>(context, listen: false).color;
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(color),
      ),
      child: child,
    );
  }
}
