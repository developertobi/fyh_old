/// -----------------------------------------------------------------
/// 
/// File: deck_card.dart
/// Project: Official Cali Connect
/// File Created: Tuesday, June 30th, 2020
/// Description: 
/// 
/// Author: Timothy Itodo - timothy@longsoftware.io
/// -----
/// Last Modified: Sunday, November 8th, 2020
/// Modified By: Timothy Itodo - timothy@longsoftware.io
/// -----
/// 
/// Copyright (C) 2020 - 2020 Long Software LLC. & Official Cali Connect
/// 
/// -----------------------------------------------------------------

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
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
