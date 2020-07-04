import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/models/category.dart';
import 'package:naija_charades/providers/firestore_data.dart';

import 'package:naija_charades/widgets/category_decks.dart';
import 'package:provider/provider.dart';

import '../colors.dart' as AppColors;

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: AppColors.prussianBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: const Text(
                  'BLACHARADES',
                  style: TextStyle(fontSize: 35),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Consumer<FirestoreData>(
                  builder: (_, firestoreData, __) {
                    return FutureBuilder<List<Category>>(
                      future: firestoreData.updateData(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          var categories = snapshot.data;
                          return ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (_, i) {
                              return CategoryDecks(
                                categoryTitle: categories[i].title,
                                decks: categories[i].decks,
                              );
                            },
                          );
                        } else {
                          // handle error
                          return Container();
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
