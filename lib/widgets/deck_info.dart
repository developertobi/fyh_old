import 'package:flutter/material.dart';
import 'package:naija_charades/providers/words.dart';
import 'package:naija_charades/screens/game_screen.dart';
import 'package:provider/provider.dart';

class DeckInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
            child: _buildText(context: context, text: 'Title', fontSize: 20)),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: _buildText(
              context: context,
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit Vivamus at sem maximus, condimentum nibh et, suscipit nunc. Curabitur iaculis diam erat. Curabitur sit amet justo nibh. Vestibulum auctor sapien in ullamcorper rhoncus.',
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
                      'words':
                          Provider.of<Words>(context, listen: false).words,
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
      style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: fontSize,
          ),
    );
  }
}
