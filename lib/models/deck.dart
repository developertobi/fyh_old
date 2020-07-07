import 'package:flutter/material.dart';

class Deck {
  final String title;
  final String description;
  final int iconCodePoint;
  final List words;

  const Deck({
    @required this.title,
    @required this.description,
    @required this.iconCodePoint,
    @required this.words,
  });
}
