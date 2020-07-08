import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:naija_charades/colors.dart' as AppColors;

// ignore: must_be_immutable
class RoundButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final bool isFocused;
  double width;

  RoundButton({
    this.onPressed,
    @required this.buttonText,
    this.isFocused = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    width ??= (MediaQuery.of(context).size.width - 60) / 2;

    return RaisedButton(
      onPressed: onPressed,
      disabledTextColor: Colors.white,
      color: isFocused
          ? AppColors.persimmon
          : Colors.transparent.withOpacity(0.0000000000000000001),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        width: width,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          // color: Colors.grey,
        ),
        child: Center(
          child: AutoSizeText(
            buttonText,
            maxLines: 2,
            maxFontSize: 20,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
