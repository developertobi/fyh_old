import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:naija_charades/constants.dart';
import 'package:naija_charades/providers/results.dart';
import 'package:naija_charades/providers/video_file.dart';
import 'package:naija_charades/screens/game_screen.dart';
import 'package:naija_charades/widgets/results/result_dialog_button.dart';
import 'package:naija_charades/widgets/results/video_preview.dart';
import 'package:naija_charades/widgets/results/close_button.dart';
import 'package:naija_charades/widgets/results/responses.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ResultsDialog extends StatelessWidget {
  final bool showVideo;
  const ResultsDialog({required this.showVideo});

  @override
  Widget build(BuildContext context) {
    final resultsProvider = Provider.of<Results>(context, listen: false);
    final videoFilePath = Provider.of<VideoFile>(context).path;
    print('Show video status $showVideo');

    return Dialog(
      backgroundColor: Color(resultsProvider.colorHex),
      insetPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 30,
              right: 20,
              left: 20,
            ),
            // height: 600,
            child: Column(
              children: <Widget>[
                Container(
                  height: 90,
                  child: AspectRatio(
                      aspectRatio: kDeckCardAspectRatio,
                      child: Image.network(resultsProvider.deckImageUrl)),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'You got ',
                        style: kNunitoTextStyle.copyWith(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: resultsProvider.score.toString(),
                        style: kNunitoTextStyle.copyWith(
                          fontSize: 60,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' right!',
                        style: kNunitoTextStyle.copyWith(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Responses(responses: resultsProvider.responses),
                        const SizedBox(height: 15),
                        if (showVideo) VideoPreview(videoFilePath),
                        const SizedBox(height: 15),
                        ButtonBar(
                          buttonPadding: EdgeInsets.all(0),
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            if (showVideo)
                              ResultsDialogButton(
                                icon: Icons.save_alt,
                                onPressed: () =>
                                    _saveVideo(context, videoFilePath),
                                text: 'Save Video',
                              ),
                            ResultsDialogButton(
                              icon: Icons.loop,
                              onPressed: () => _playAgain(context),
                              text: 'Play Again',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CloseResultsButton()
        ],
      ),
    );
  }

  void _playAgain(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      GameScreen.routeName,
      (route) => false,
      arguments: {
        'words': Provider.of<Results>(context, listen: false).words,
      },
    );
  }

  void _saveVideo(BuildContext context, String videoFilePath) async {
    HapticFeedback.mediumImpact();

    await Permission.storage.request();

    if (await Permission.storage.isGranted) {
      GallerySaver.saveVideo(videoFilePath).then((saved) {
        print('Video saved? $saved');
        _buildFlushBar('Video Saved! $saved', context);
      });
    } else {
      _buildFlushBar('Video not saved!', context);
    }
  }

  _buildFlushBar(String messageText, BuildContext context) {
    Flushbar(
      messageText: Text(
        messageText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      duration: Duration(seconds: 1),
      animationDuration: Duration(milliseconds: 500),
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }
}
