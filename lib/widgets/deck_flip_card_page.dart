import 'package:flutter/material.dart';

import '../colors.dart' as AppColors;

class DeckFlipCardPage extends StatelessWidget {
  final Widget child;
  const DeckFlipCardPage({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.cadetBlueCrayola,
      ),
      child: child,
    );
  }
}
