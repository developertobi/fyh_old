import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:naija_charades/widgets/category_decks.dart';

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
      body: SingleChildScrollView(
        child: SafeArea(
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
                CategoryDecks(
                  categoryTitle: 'Music',
                  categoryList: [],
                ),
                CategoryDecks(
                  categoryTitle: 'Sports',
                  categoryList: [],
                ),
                CategoryDecks(
                  categoryTitle: 'Pop Culture',
                  categoryList: [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
