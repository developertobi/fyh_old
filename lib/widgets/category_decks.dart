import 'package:flutter/material.dart';

import 'deck.dart';

class CategoryDecks extends StatelessWidget {
  final categoryTitle;
  final List categoryList;

  const CategoryDecks({this.categoryList, this.categoryTitle});

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
            itemCount: 5,
            itemBuilder: (_, i) => Deck(),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
