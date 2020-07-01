import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/colors.dart' as AppColors;
import 'package:naija_charades/widgets/ready_timer.dart';
import 'package:naija_charades/widgets/status.dart';
import 'package:naija_charades/widgets/words.dart';
import 'package:sensors/sensors.dart';

import 'dart:async';

import 'package:tilt_action/tilt_action.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/gameScreen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Tilt _tilt;
  StreamSubscription _streamSubscription;
  Color _backgroundColor = AppColors.prussianBlue;
  Widget _content = const Center(
      child: Text('Place on ForeHead', style: TextStyle(fontSize: 70)));

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);

    _startListeningForHorizontalPhonePosition();
    _initTilt();
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _tilt.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Container(
        child: Center(
          child: FractionallySizedBox(
            heightFactor: 0.8,
            widthFactor: 0.8,
            alignment: Alignment.center,
            child: _content,
          ),
        ),
      ),
    );
  }

  void _setContent(Widget content) {
    setState(() {
      _content = content;
    });
  }

  void _changeBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  void _startListeningForHorizontalPhonePosition() {
    const gravity = 9.80665;
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      if ((event.x - gravity).abs() < 2) {
        _setContent(
          ReadyTimer(onReady: () {
            _setContent(Word());
            _tilt.startListening();
          }),
        );
        _streamSubscription.cancel();
      }
    });
  }

  void _initTilt() {
    _tilt = Tilt.waitForStart(
      onTiltUp: () {
        _setContent(Status(isCorrect: true));
        _changeBackgroundColor(AppColors.vagasGold);
      },
      onNormal: () {
        _setContent(Word());
        _changeBackgroundColor(AppColors.prussianBlue);
      },
      onTiltDown: () {
        _setContent(Status(isCorrect: false));
        _changeBackgroundColor(AppColors.persimmon);
      },
    );
  }
}
