import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naija_charades/models/deck.dart';

class FirestoreData {
  List<Deck> decks;

  Future<List<Deck>> updateData() async {
    List<Deck> currentDecks = [];

    final snapshot =
        await Firestore.instance.collection('app-data').getDocuments();

    for (var document in snapshot.documents) {
      var deck = document.data;
      currentDecks.add(
        Deck(
          backgroundUrl: deck['background_url'],
          description: deck['description'],
          title: deck['title'],
          words: deck['words'],
          color: int.parse(deck['color']),
        ),
      );
    }

    decks = currentDecks;
    return currentDecks;
  }
}
