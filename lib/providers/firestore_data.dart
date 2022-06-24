import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naija_charades/models/deck.dart';

class FirestoreData {
  late List<Deck> decks;

  Future<List<Deck>> updateData() async {
    // List<Deck> currentDecks = [];
    //
    // final snapshot =
    //     await FirebaseFirestore.instance.collection('app-data').get();
    //
    // for (var document in snapshot.docs) {
    //   var deck = document.data();
    //   currentDecks.add(
    //     Deck(
    //       backgroundUrl: deck['background_url'],
    //       description: deck['description'],
    //       title: deck['title'],
    //       words: deck['words'],
    //       color: int.parse(deck['color']),
    //     ),
    //   );
    // }
    //
    // decks = currentDecks;
    await Future.delayed(Duration(seconds: 2));
    return List.generate(
      20,
      (index) => Deck(
        title: 'Title $index',
        backgroundUrl:
            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
        description: 'Description $index',
        words: List.generate(100, (index) => 'Word $index'),
        color: 0xffFF0000,
      ),
    );
    [
      Deck(
        title: 'Deck 1',
        backgroundUrl:
            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
        description: 'Description 1',
        words: ['words 1', 'words 2', 'words 3', 'words 4'],
        color: 0xff00FF00,
      ),
      Deck(
        title: 'Deck 2',
        backgroundUrl:
            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
        description: 'Description 1',
        words: List.generate(100, (index) => 'Word $index'),
        color: 0xffFF0000,
      ),
      Deck(
        title: 'Deck 3',
        backgroundUrl:
            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
        description: 'Description 1',
        words: ['words 1', 'words 2', 'words 3', 'words 4'],
        color: 0xff0000FF,
      ),
      Deck(
        title: 'Deck 4',
        backgroundUrl:
            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
        description: 'Description 1',
        words: ['words 1', 'words 2', 'words 3', 'words 4'],
        color: 0xff808080,
      ),
      Deck(
        title: 'Deck 5',
        backgroundUrl:
            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
        description: 'Description 1',
        words: ['words 1', 'words 2', 'words 3', 'words 4'],
        color: 0xffBF40BF,
      )
    ];
  }
}
