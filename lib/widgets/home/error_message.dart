import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:naija_charades/screens/home_screen.dart';
import 'package:naija_charades/widgets/shared/round_button.dart';

import '../../colors.dart' as AppColors;

class ErrorMsg extends StatelessWidget {
  final String message;
  ErrorMsg({required this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleAnimatedTextKit(
            text: [
              'Oops Something went wrong',
              'Please check internet connection',
            ],
            textStyle: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),
            textAlign: TextAlign.center,
            // alignment: AlignmentDirectional.center,
            repeatForever: true,
          ),
          SizedBox(
            height: 20,
          ),
          RoundButton(
            child: Text(message),
            color: AppColors.prussianBlue,
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routeName),
          ),
        ],
      ),
    );
  }
}
