import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naija_charades/models/category.dart';
import 'package:naija_charades/models/deck.dart';

class FirestoreData {
  List<Category> data;

  Future<List<Category>> updateData() async {
    List<Category> categories = [];

    final snapshot =
        await Firestore.instance.collection('app-data').getDocuments();

    for (var firestoreCategory in snapshot.documents) {
      var firestoreDecks = firestoreCategory.data['decks'];
      List<Deck> decks = [];

      for (var deck in firestoreDecks) {
        decks.add(
          Deck(
            title: deck['title'],
            description: deck['description'],
            words: deck['words'],
          ),
        );
      }

      categories.add(
        Category(
          title: firestoreCategory.documentID,
          decks: decks,
        ),
      );
    }
    
    data = categories;
    return categories;
  }
}
