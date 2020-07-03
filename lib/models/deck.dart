import 'package:flutter/material.dart';

class Deck {
  final String title;
  final String description;
  final String icon;
  final List words;

  const Deck({
    @required this.title,
    @required this.description,
    this.icon,
    @required this.words,
  });
}
