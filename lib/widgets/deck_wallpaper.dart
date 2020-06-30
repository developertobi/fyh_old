import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DeckWallpaper extends StatelessWidget {
  final bool isDialog;
  final String title;

  const DeckWallpaper({
    this.isDialog = false,
    this.title = 'Afro Beats',
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
                  Icons.hot_tub,
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
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 25),
                    )
                  : AutoSizeText(
                      title,
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
