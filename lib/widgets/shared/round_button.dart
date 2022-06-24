import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final double width;
  final Color color;

  RoundButton({
    required this.onPressed,
    required this.child,
    this.width = 230,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      disabledTextColor: Colors.white,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
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
