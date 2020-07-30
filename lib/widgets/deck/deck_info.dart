import 'package:flutter/material.dart';
import 'package:naija_charades/constants.dart';
import 'package:naija_charades/models/deck.dart';
import 'package:naija_charades/models/sound_controller.dart';
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
            height: 130,
            child: AspectRatio(
                aspectRatio: kDeckCardAspectRatio,
                child: Image.network(deck.backgroundUrl)),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              deck.description,
              textAlign: TextAlign.justify,
              style: kNunitoTextStyle.copyWith(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RoundButton(
              child: Text(
                'Play Now',
                style: kNunitoTextStyle.copyWith(
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                SoundController.play('select-deck-sound.wav');
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
}
