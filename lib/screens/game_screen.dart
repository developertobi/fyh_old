/// -----------------------------------------------------------------
/// 
/// File: game_screen.dart
/// Project: Official Cali Connect
/// File Created: Tuesday, June 30th, 2020
/// Description: 
/// 
/// Author: Timothy Itodo - timothy@longsoftware.io
/// -----
/// Last Modified: Sunday, November 8th, 2020
/// Modified By: Timothy Itodo - timothy@longsoftware.io
/// -----
/// 
/// Copyright (C) 2020 - 2020 Long Software LLC. & Official Cali Connect
/// 
/// -----------------------------------------------------------------



import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:naija_charades/constants.dart';
import 'package:naija_charades/main.dart'; // imported this bc of cameras var. kinda hacky
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/models/response.dart';
import 'package:naija_charades/models/sound_controller.dart';
import 'package:naija_charades/providers/results.dart';
import 'package:naija_charades/providers/video_file.dart';
import 'package:naija_charades/screens/home_screen.dart';
import 'package:naija_charades/widgets/game/ready_timer.dart';
import 'package:naija_charades/widgets/game/status.dart';
import 'package:naija_charades/widgets/game/time_up.dart';
import 'package:naija_charades/widgets/game/word.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sensors/sensors.dart';
import 'package:tilt_action/tilt_action.dart';
import 'package:wakelock/wakelock.dart';

enum TiltAction {
  up,
  down,
}

class GameScreen extends StatefulWidget {
  static const routeName = '/gameScreen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with AfterLayoutMixin<GameScreen> {
  bool contentIsStatus = false;
  CameraController _cameraController;
  PermissionStatus _cameraPermissionStatus;
  PermissionStatus _micPermissionStatus;
  String _videoFilePath;
  int wordsIndex;
  List words = [];
  List<Response> responses = [];
  Tilt _tilt;
  int timeLeft = 60;
  int _score = 0;
  StreamSubscription _streamSubscription;
  Color _backgroundColor = Colors.black;

  Widget _content = FractionallySizedBox(
      heightFactor: 0.75,
      widthFactor: 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AutoSizeText(
            'Place on ForeHead'.toUpperCase(),
            style: kNunitoTextStyle.copyWith(
                fontSize: 70, fontWeight: FontWeight.w900),
            minFontSize: 20,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Image.asset('assets/arrow-down.png'),
              SizedBox(width: 10),
              Expanded(
                child: AutoSizeText(
                  'Tilt down for Correct',
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: kNunitoTextStyle.copyWith(fontSize: 20),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: AutoSizeText(
                  'Tilt up for Pass',
                  textAlign: TextAlign.right,
                  style: kNunitoTextStyle.copyWith(fontSize: 20),
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 10),
              Image.asset('assets/arrow-up.png'),
            ],
          )
        ],
      ));

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      Platform.isIOS
          ? DeviceOrientation.landscapeRight
          : DeviceOrientation.landscapeLeft,
    ]);
    _initCameraRequirements();
    _startListeningForHorizontalPhonePosition();
    _initTilt();
    Wakelock.enable();
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _initWords();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _tilt.stopListening();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: _cameraController != null &&
                    _cameraController.value.isInitialized
                ? RotatedBox(
                    quarterTurns: 3,
                    child: AspectRatio(
                      aspectRatio: _cameraController.value.aspectRatio,
                      child: CameraPreview(_cameraController),
                    ),
                  )
                : Container(),
          ),
          Opacity(
            opacity: 0.9,
            child: Scaffold(
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
            ),
          ),
          Positioned(
            top: 30,
            left: 50,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  Feather.arrow_left_circle,
                  size: 40,
                ),
                onPressed: () {
                  // Explore this function. It's Hacky
                  setState(() {
                    timeLeft = 0;
                  });
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeScreen.routeName, (route) => false);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _changeBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  void _initCameraRequirements() async {
    _cameraPermissionStatus = await Permission.camera.status;
    _micPermissionStatus = await Permission.microphone.status;

    Provider.of<Results>(context, listen: false).permissionStatuses = {
      'camera': _cameraPermissionStatus,
      'microphone': _micPermissionStatus,
    };

    if (_cameraPermissionStatus.isGranted && _micPermissionStatus.isGranted) {
      // Init camera
      _cameraController = CameraController(cameras[1], ResolutionPreset.medium);
      _cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });

      _setFilePath();
    }
  }

  void _setFilePath() async {

    // TODO: Confirm if temp dir is really temp
    Directory appTempDir = await getTemporaryDirectory();
    String dirPath = '${appTempDir.path}/videos';
    await Directory(dirPath).create(recursive: true);

    _videoFilePath = '$dirPath/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

    // if (await File(_videoFilePath).exists()) {
    //   await File(_videoFilePath).delete();
    // }

    Provider.of<VideoFile>(context, listen: false).setPath(_videoFilePath);
  }

  void _initTilt() {
    _tilt = Tilt.waitForStart(
      onTiltUp: () => _onTilt(TiltAction.up),
      onTiltDown: () {
        _onTilt(TiltAction.down);
        _score++;
      },
      onNormal: () {
        contentIsStatus = false;
        _setContent(
          Word(
            answer: words[wordsIndex],
            timeLeft: toTwoDigits(timeLeft),
            isLast5Seconds: timeLeft < 6,
          ),
        );
        _changeBackgroundColor(Colors.black);
      },
    );
  }

  void _initWords() {
    Map<String, List> args = ModalRoute.of(context).settings.arguments;
    words = args['words'];
    Provider.of<Results>(context, listen: false).words = words;
    _randomizeWordIndex();
  }

  void _onTilt(TiltAction direction) {
    contentIsStatus = true;

    _setContent(Status(isCorrect: direction == TiltAction.down));

    // direction == TiltAction.up
    //     ? SoundController.play('pass-sound.wav')
    //     : SoundController.play('correct-sound.wav');

    direction == TiltAction.up
        ? _changeBackgroundColor(kPassColor)
        : _changeBackgroundColor(kCorrectColor);

    responses.add(
      Response(
        isCorrect: direction == TiltAction.down,
        word: words[wordsIndex],
      ),
    );

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
        SoundController.play('3-sec-countdown-sound.wav');
        _setContent(
          ReadyTimer(
            onReady: () {
              HapticFeedback.vibrate();
              _startTimerCountdown();
              _tilt.startListening();
              _cameraController?.startVideoRecording(_videoFilePath);
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
          _cameraController?.stopVideoRecording();

          final resultProvider = Provider.of<Results>(context, listen: false);
          resultProvider.responses = responses;
          resultProvider.score = _score;

          HapticFeedback.vibrate();
          SoundController.play('timeup-sound.wav');
          _setContent(
            TimeUp(),
          );
          _changeBackgroundColor(kTimeUpColor);
        } else {
          timeLeft -= 1;
          bool isLast5sec = false;

          if (timeLeft < 6) {
            if (timeLeft == 4)
              // SoundController.play('5-sec-countdown-sound.wav');
              HapticFeedback.vibrate();
            isLast5sec = true;
          }

          if (!contentIsStatus) {
            _setContent(
              Word(
                answer: words[wordsIndex],
                timeLeft: toTwoDigits(timeLeft),
                isLast5Seconds: isLast5sec,
              ),
            );
          }
        }
      },
    );
  }

  String toTwoDigits(int num) {
    if ((num / 10).floor() == 0) return '0${num.toString()}';
    return num.toString();
  }
}
