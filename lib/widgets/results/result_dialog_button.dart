import 'package:flutter/material.dart';
import 'package:naija_charades/constants.dart';
import 'package:naija_charades/widgets/shared/round_button.dart';

class ResultsDialogButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final String text;

  const ResultsDialogButton({
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return RoundButton(
      width: (MediaQuery.of(context).size.width - 70) / 2,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 30,
          ),
          SizedBox(width: 5),
          Text(
            text,
            style: kNunitoTextStyle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
