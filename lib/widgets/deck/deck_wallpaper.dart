import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:naija_charades/models/deck.dart';
import 'package:provider/provider.dart';

class DeckWallpaper extends StatelessWidget {
  final bool isDialog;

  const DeckWallpaper({
    this.isDialog = false,
  });

  @override
  Widget build(BuildContext context) {
    final deck = Provider.of<Deck>(context, listen: false);

    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: FittedBox(
              child: Center(
                child: Icon(
                  IconData(deck.iconCodePoint, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              child: isDialog
                  ? Text(
                      deck.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  : AutoSizeText(
                      deck.title,
                      maxLines: 3,
                      minFontSize: 10,
                      maxFontSize: 20,
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.bold),
                    ),
              alignment: Alignment.bottomCenter,
            ),
          ),
        ],
      ),
    );
  }
}
