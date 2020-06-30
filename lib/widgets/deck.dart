import 'package:flutter/material.dart';

import '../colors.dart' as AppColors;
import 'deck_info_dialog.dart';
import 'deck_wallpaper.dart';

class Deck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.cadetBlueCrayola,
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: () => _showDeckInfoDialog(context),
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: 140,
            child: DeckWallpaper(),
          ),
        ));
  }

  void _showDeckInfoDialog(BuildContext context) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: DeckInfoDialog(),
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


