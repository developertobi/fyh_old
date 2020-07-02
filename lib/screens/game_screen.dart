import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:naija_charades/main.dart'; // imported this bc of cameras var. kinda hacky
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/colors.dart' as AppColors;
import 'package:naija_charades/models/response.dart';
import 'package:naija_charades/providers/responses.dart';
import 'package:naija_charades/providers/video_file.dart';
import 'package:naija_charades/widgets/ready_timer.dart';
import 'package:naija_charades/widgets/status.dart';
import 'package:naija_charades/widgets/time_up.dart';
import 'package:naija_charades/widgets/word.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
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
  CameraController _cameraController;
  String _videoFilePath;
  int wordsIndex;
  List<String> words = [];
  List<Response> responses = [];
  Tilt _tilt;
  int timeLeft = 10;
  int _score = 0;
  StreamSubscription _streamSubscription;
  Color _backgroundColor = AppColors.prussianBlue;
  Widget _content = const Center(
      child: Text('Place on ForeHead', style: TextStyle(fontSize: 70)));

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);

    _initCameraRequirements();

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
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: _cameraController.value.isInitialized
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
      ],
    );
  }

  void _changeBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  void _initCameraRequirements() {
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

  void _setFilePath() async {
    print('set path called');
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dirPath = '${appDocDir.path}/videos';
    await Directory(dirPath).create(recursive: true);

    _videoFilePath = '$dirPath/video.mp4';

    Provider.of<VideoFile>(context, listen: false).setPath(_videoFilePath);
  }

  void _initTilt() {
    print('Tilt initialized');

    _tilt = Tilt.waitForStart(
      onTiltUp: () {
        _onTilt(TiltAction.up);
        _score++;
      },
      onTiltDown: () => _onTilt(TiltAction.down),
      onNormal: () {
        contentIsStatus = false;
        print('normal');
        _setContent(
          Word(
            score: _score.toString(),
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

    responses.add(
      Response(
        isCorrect: direction == TiltAction.up,
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
        _setContent(
          ReadyTimer(
            onReady: () {
              _startTimerCountdown();
              _tilt.startListening();
              _cameraController.startVideoRecording(_videoFilePath);
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
          _cameraController.stopVideoRecording();

          final responseProvider =
              Provider.of<Responses>(context, listen: false);
          responseProvider.responses = responses;
          responseProvider.score = _score;

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
            _setContent(Word(
              answer: words[wordsIndex],
              score: _score.toString(),
              timeLeft: timeLeft,
              isLast5Seconds: isLast5sec,
            ));
          }
        }
      },
    );
  }
}
