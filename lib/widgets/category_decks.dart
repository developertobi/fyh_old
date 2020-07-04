import 'package:flutter/material.dart';
import 'package:naija_charades/models/category.dart';
import 'package:naija_charades/models/deck.dart';
import 'package:provider/provider.dart';

import 'deck_card.dart';

class CategoryDecks extends StatelessWidget {
  final categoryTitle;
  final List<Deck> decks;

  const CategoryDecks({this.decks, this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          categoryTitle,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: decks.length,
            itemBuilder: (_, i) => Provider<Deck>.value(
              value: decks[i],
              child: DeckCard(),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
