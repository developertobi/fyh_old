/// -----------------------------------------------------------------
///
/// File: game_screen.dart
/// Project: Official Cali Connect
/// File Created: Tuesday, June 30th, 2020
/// Description:
///
/// Author: Timothy Itodo - timothy@longsoftware.io
/// -----
/// Last Modified: Sunday, January 31st, 2021
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
// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:just_audio/just_audio.dart';
import 'package:naija_charades/constants.dart';
import 'package:naija_charades/main.dart'; // imported this bc of cameras var. kinda hacky
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naija_charades/models/response.dart';
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
import 'package:sensors_plus/sensors_plus.dart';
// import 'package:sensors/sensors.dart';
import 'package:wakelock/wakelock.dart';

import '../utils/tilt.dart';

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
  bool permissionLoading = false;
  late CameraController _cameraController;
  late PermissionStatus _cameraPermissionStatus;
  late PermissionStatus _micPermissionStatus;
  late PermissionStatus _storagePermissionStatus;
  late String _videoFilePath;
  late int wordsIndex;
  List words = [];
  List<Response> responses = [];
  late TiltUtil _tilt;
  int timeLeft = 10;
  int _score = 0;
  late StreamSubscription _streamSubscription;
  Color _backgroundColor = Colors.blue;
  final player = AudioPlayer();
  Widget? _content;

  bool timerVisible = false;
  static const maxSeconds = 3;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      }
      if (seconds == 0) {
        timer.cancel();
        HapticFeedback.vibrate();
        _startTimerCountdown();
        _tilt.startListening();
        _cameraController.startVideoRecording();
      }
    });
  }

  initContent() {
    _content = GestureDetector(
      onTap: () {
        startGame();
      },
      child: FractionallySizedBox(
          heightFactor: 0.75,
          widthFactor: 0.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'PLACE ON FOREHEAD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                'OR TAP SCREEN TO START',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )),
    );
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      Platform.isIOS
          ? DeviceOrientation.landscapeRight
          : DeviceOrientation.landscapeLeft,
    ]);
    initContent();
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
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: permissionLoading
          ? CircularProgressIndicator()
          : Stack(
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
                  opacity: 0.85,
                  child: Scaffold(
                    // backgroundColor: _backgroundColor,
                    body: Container(
                      decoration: BoxDecoration(
                        color: _backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 2),
                        image: const DecorationImage(
                          image: AssetImage('assets/play_background.png'),
                          opacity: 0.05,
                        ),
                      ),
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

  Future<void> _initCameraRequirements() async {
    setState(() {
      permissionLoading = true;
    });
    _cameraPermissionStatus = await Permission.camera.status;
    _micPermissionStatus = await Permission.microphone.status;
    _storagePermissionStatus = await Permission.storage.status;

    print('_cameraPermissionStatus: $_cameraPermissionStatus');
    print('_micPermissionStatus: $_micPermissionStatus');
    print('_storagePermissionStatus: $_storagePermissionStatus');

    Provider.of<Results>(context, listen: false).permissionStatuses = {
      'camera': _cameraPermissionStatus,
      'microphone': _micPermissionStatus,
      'storage': _storagePermissionStatus,
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
    }
    setState(() {
      permissionLoading = false;
    });
  }

  void _initTilt() {
    _tilt = TiltUtil.waitForStart(
      offset: 1.0,
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
        _changeBackgroundColor(Colors.blue);
      },
    );
  }

  void _initWords() {
    Map<String, List> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, List>;
    words = args['words']!;
    Provider.of<Results>(context, listen: false).words = words;
    _randomizeWordIndex();
  }

  void _onTilt(TiltAction direction) {
    contentIsStatus = true;

    _setContent(Status(isCorrect: direction == TiltAction.down));

    if (direction == TiltAction.up) {
      _changeBackgroundColor(kPassColor);
      player.setAsset('assets/pass-sound.wav');
      player.play();
    } else if (direction == TiltAction.down) {
      _changeBackgroundColor(kCorrectColor);
      player.setAsset('assets/correct-sound.wav');
      player.play();
    }

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
        accelerometerEvents.listen((AccelerometerEvent event) async {
      print('AccelerometerEvent x::: ${event.x}');
      print('AccelerometerEvent y::: ${event.y}');
      print('AccelerometerEvent z::: ${event.z}');
      print('AccelerometerEvent x - gravity::: ${event.x - gravity}');
      if ((event.x - gravity) > 1) {
        startGame();
        _streamSubscription.cancel();
      }
    });
  }

  void startGame() {
    startTimer();
    player.setAsset('assets/3-sec-countdown-sound.wav');
    player.play();
    _setContent(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 164.6,
            height: 164.6,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: seconds / 3,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  backgroundColor: Colors.grey,
                  color: Color(0x66008EB1),
                  strokeWidth: 10,
                ),
                Center(
                  child: Text(
                    seconds.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 88.14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'GET READY',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          )
        ],
      ),
      // ReadyTimer(
      //   onReady: () {
      //     HapticFeedback.vibrate();
      //     _startTimerCountdown();
      //     _tilt.startListening();
      //     _cameraController.startVideoRecording();
      //   },
      // ),
    );
  }

  void _startTimerCountdown() {
    Timer.periodic(
      Duration(seconds: 1),
      (t) async {
        if (timeLeft < 1) {
          t.cancel();
          _tilt.stopListening();
          _cameraController.stopVideoRecording().then((value) {
            Provider.of<VideoFile>(context, listen: false).setPath(value.path);
          });

          final resultProvider = Provider.of<Results>(context, listen: false);
          resultProvider.responses = responses;
          resultProvider.score = _score;

          HapticFeedback.vibrate();
          player.setAsset('assets/timeup-sound.wav');
          player.play();
          _setContent(
            TimeUp(),
          );
          _changeBackgroundColor(kTimeUpColor);
        } else {
          timeLeft -= 1;
          bool isLast5sec = false;

          if (timeLeft < 6) {
            if (timeLeft == 4)
              player.setAsset('assets/5-sec-countdown-sound.wav');
            player.play();
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
