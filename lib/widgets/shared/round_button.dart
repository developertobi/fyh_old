import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final double width;

  RoundButton({
    @required this.onPressed,
    @required this.child,
    this.width = 230,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      disabledTextColor: Colors.white,
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Container(
        width: width,
        height: 60,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
