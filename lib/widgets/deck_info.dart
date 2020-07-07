import 'package:flutter/material.dart';
import 'package:naija_charades/models/deck.dart';
import 'package:naija_charades/screens/game_screen.dart';
import 'package:provider/provider.dart';

class DeckInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = Provider.of<Deck>(context, listen: false).title;
    final description = Provider.of<Deck>(context, listen: false).description;
    final words = Provider.of<Deck>(context, listen: false).words;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(child: _buildText(context: context, text: title, fontSize: 20)),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: _buildText(
              context: context,
              text: description,
              fontSize: 18,
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
                child: Text('Play'),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    GameScreen.routeName,
                    arguments: {
                      'words': words,
                    },
                  );
                })
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
        color: Colors.white,
      ),
    );
  }
}
