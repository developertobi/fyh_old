
import 'deck.dart';

class Category {
  final String title;
  final List<Deck> decks;

  const Category({
    required this.title,
    required this.decks,
  });

  // List<Deck> get decks => [..._decks];
}
