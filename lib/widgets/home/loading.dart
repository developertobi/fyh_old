import 'package:flutter/material.dart';
import '../../colors.dart' as AppColors;

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 10,
        valueColor: new AlwaysStoppedAnimation<Color>(AppColors.prussianBlue),
      ),
    );
  }
}
