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
                  Icons.speaker_group,
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
                      Provider.of<Deck>(context, listen: false).title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 25),
                    )
                  : AutoSizeText(
                      Provider.of<Deck>(context, listen: false).title,
                      maxLines: 3,
                      minFontSize: 10,
                      maxFontSize: 20,
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.5,
                    ),
              alignment: Alignment.bottomCenter,
            ),
          ),
        ],
      ),
    );
  }
}
