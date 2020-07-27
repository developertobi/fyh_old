import 'package:flutter/material.dart';

class CloseResultsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 15,
      top: 15,
      child: IconButton(
        color: Colors.black,
        icon: Icon(
          Icons.close,
          size: 35,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
