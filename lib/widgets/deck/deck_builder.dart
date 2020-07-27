import 'package:flutter/material.dart';
import 'package:naija_charades/models/deck.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'deck_card.dart';

class DeckBuilder extends StatelessWidget {
  const DeckBuilder({
    Key key,
    @required this.decks,
  }) : super(key: key);

  final List<Deck> decks;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: decks.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: kDeckCardAspectRatio,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (_, i) {
          return Provider<Deck>.value(
            value: decks[i],
            child: DeckCard(),
          );
        });
  }
}
