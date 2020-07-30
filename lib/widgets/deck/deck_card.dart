import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/models/deck.dart';
import 'package:naija_charades/models/sound_controller.dart';
import 'package:provider/provider.dart';

import 'deck_alert_dialog.dart';

class DeckCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deck = Provider.of<Deck>(context, listen: false);
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        SoundController.play('select-deck-sound.wav');
        _showDeckInfoDialog(context, deck);
      },
      child: ClipRect(
        child: Image.network(
          deck.backgroundUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  void _showDeckInfoDialog(BuildContext context, Deck deck) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Provider<Deck>.value(
              value: deck,
              child: DeckAlertDialog(),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      // ignore: missing_return
      pageBuilder: (context, animation1, animation2) {},
    );
  }
}
