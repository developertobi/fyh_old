import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:naija_charades/models/deck.dart';
import 'package:provider/provider.dart';

import 'deck_flip_card_page.dart';
import 'deck_info.dart';

class DeckAlertDialog extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      if (cardKey.currentState != null) cardKey.currentState?.toggleCard();
    });

    var deck = Provider.of<Deck>(context, listen: false);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(15),
      content: FlipCard(
        key: cardKey,
        flipOnTouch: false,
        front: DeckFlipCardPage(
          child: Image.network(deck.backgroundUrl),
        ),
        back: DeckFlipCardPage(
          child: DeckInfo(),
        ),
      ),
    );
  }
}
