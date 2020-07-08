import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:naija_charades/widgets/deck/deck_wallpaper.dart';

import 'deck_flip_card_page.dart';
import 'deck_info.dart';

class DeckInfoDialog extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      if(cardKey.currentState != null)
        cardKey.currentState.toggleCard();
    });

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: FlipCard(
        key: cardKey,
        flipOnTouch: false,
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
