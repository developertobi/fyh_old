import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/colors.dart' as AppColors;
import 'package:naija_charades/widgets/ready_timer.dart';
import 'package:naija_charades/widgets/status.dart';
import 'package:naija_charades/widgets/time_up.dart';
import 'package:naija_charades/widgets/words.dart';
import 'package:sensors/sensors.dart';

import 'package:tilt_action/tilt_action.dart';

enum TiltAction {
  up,
  down,
}

class GameScreen extends StatefulWidget {
  static const routeName = '/gameScreen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool contentIsStatus = false;
  int wordsIndex;
  List<String> words = [];
  Tilt _tilt;
  int timeLeft = 2;
  StreamSubscription _streamSubscription;
  Color _backgroundColor = AppColors.prussianBlue;
  Widget _content = const Center(
      child: Text('Place on ForeHead', style: TextStyle(fontSize: 70)));

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);

    // init words & wordsIndex
    Future.delayed(Duration.zero, () {
      Map<String, List> args = ModalRoute.of(context).settings.arguments;
      words = args['words'];
      _randomizeWordIndex();
    });

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

  void _changeBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  void _initTilt() {
    print('Tilt initialized');

    _tilt = Tilt.waitForStart(
      onTiltUp: () => _onTilt(TiltAction.up),
      onTiltDown: () => _onTilt(TiltAction.down),
      onNormal: () {
        contentIsStatus = false;
        print('normal');
        _setContent(
          Word(
            answer: words[wordsIndex],
            timeLeft: timeLeft,
          ),
        );
        _changeBackgroundColor(AppColors.prussianBlue);
      },
    );
  }

  void _onTilt(TiltAction direction) {
    print('up or down');
    contentIsStatus = true;
    _setContent(Status(isCorrect: direction == TiltAction.up ? true : false));

    direction == TiltAction.up
        ? _changeBackgroundColor(AppColors.vagasGold)
        : _changeBackgroundColor(AppColors.persimmon);

    words.removeAt(wordsIndex);
    _randomizeWordIndex();
  }

  void _randomizeWordIndex() {
    Random random = Random();
    wordsIndex = random.nextInt(words.length);
  }

  void _setContent(Widget content) {
    setState(() {
      _content = content;
    });
  }

  void _startListeningForHorizontalPhonePosition() {
    const gravity = 9.80665;
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      if ((event.x - gravity).abs() < 2) {
        _setContent(
          ReadyTimer(
            onReady: () {
              _startTimerCountdown();
              _tilt.startListening();
            },
          ),
        );
        _streamSubscription.cancel();
      }
    });
  }

  void _startTimerCountdown() {
    Timer.periodic(
      Duration(seconds: 1),
      (t) {
        if (timeLeft < 1) {
          t.cancel();
          _tilt.stopListening();
          _setContent(TimeUp());
          _changeBackgroundColor(AppColors.rossoCorsa);
        } else {
          timeLeft -= 1;
          bool isLast5sec = false;

          if (timeLeft < 6) {
            HapticFeedback.vibrate();
            isLast5sec = true;
          }

          if (!contentIsStatus) {
            _setContent(
              Word(
                answer: words[wordsIndex],
                timeLeft: timeLeft,
                isLast5Seconds: isLast5sec,
              ),
            );
          }
        }
      },
    );
  }
}
