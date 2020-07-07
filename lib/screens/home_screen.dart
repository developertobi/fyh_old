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
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xFF191A1C),
            child: Center(
              child: Image.asset('assets/logo.jpg'),
            ),
          ),
          Container(
            color: AppColors.prussianBlue.withOpacity(0.9),
            padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
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
    );
  }
}
