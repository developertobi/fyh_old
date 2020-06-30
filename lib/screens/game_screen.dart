import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/colors.dart' as AppColors;

class GameScreen extends StatefulWidget {
  static const routeName = '/gameScreen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.prussianBlue,
      body: Container(
        child: Center(
          child: FractionallySizedBox(
            heightFactor: 0.8,
            widthFactor: 0.8,
            child: Container(
              child: Center(
                child: Text(
                  'Place on Forehead',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
