import 'package:flutter/material.dart';
import 'package:naija_charades/constants.dart';
import 'package:naija_charades/models/deck.dart';
import 'package:naija_charades/providers/results.dart';
import 'package:naija_charades/screens/game_screen.dart';
import 'package:naija_charades/widgets/shared/round_button.dart';
import 'package:provider/provider.dart';

class DeckInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deck = Provider.of<Deck>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            height: 100,
            child: AspectRatio(
                aspectRatio: kDeckCardAspectRatio,
                child: Image.network(deck.backgroundUrl)),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: _buildText(
              context: context,
              text: deck.description,
              fontSize: 18,
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RoundButton(
              child: Text(
                'Play Now',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                final resultProvider =
                    Provider.of<Results>(context, listen: false);
                resultProvider.colorHex = deck.color;
                resultProvider.deckImageUrl = deck.backgroundUrl;
                Navigator.of(context).pushNamedAndRemoveUntil(
                  GameScreen.routeName,
                  (route) => false,
                  arguments: {
                    'words': deck.words,
                  },
                );
              },
            )
          ],
        )
      ],
    );
  }

  Text _buildText({BuildContext context, String text, double fontSize}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.black,
      ),
    );
  }
}
