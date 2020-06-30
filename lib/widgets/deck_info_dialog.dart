import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:naija_charades/widgets/deck_wallpaper.dart';

import 'deck_flip_card_page.dart';
import 'deck_info.dart';

class DeckInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: FlipCard(
        front: DeckFlipCardPage(
          child: DeckWallpaper(
            isDialog: true,
          ),
        ),
        back: DeckFlipCardPage(
          child: DeckInfo(),
        ),
      ),
    );
  }
}


