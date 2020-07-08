import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:naija_charades/colors.dart' as AppColors;
import 'package:naija_charades/providers/responses.dart';
import 'package:naija_charades/providers/video_file.dart';
import 'package:naija_charades/widgets/home/round_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'video_preview.dart';

class ResultsBottomSheet extends StatelessWidget {
  final bool showVideo;

  const ResultsBottomSheet({@required this.showVideo});

  @override
  Widget build(BuildContext context) {
    final responseProvider = Provider.of<Responses>(context, listen: false);
    final videoFilePath = Provider.of<VideoFile>(context).path;

    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF51100C),
          border: Border.all(width: 0, color: Color(0xFF51100C))),
      child: FractionallySizedBox(
        heightFactor: 1.0,
        child: Container(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 30,
            right: 20,
            left: 20,
          ),
          decoration: BoxDecoration(
            color: AppColors.prussianBlue,
            borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(25),
              topRight: const Radius.circular(25),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(3)),
              ),
              SizedBox(height: 10),
              Text(
                'You answered',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                responseProvider.score.toString(),
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white30)),
                  child: ListView.builder(
                    itemCount: responseProvider.responses.length,
                    itemBuilder: (context, i) {
                      var response = responseProvider.responses[i];
                      return Text(
                        response.word,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: response.isCorrect
                              ? Colors.white
                              : Colors.white24,
                          fontSize: 34,
                          decoration: response.isCorrect
                              ? TextDecoration.none
                              : TextDecoration.lineThrough,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (showVideo) VideoPreview(videoFilePath),
              const SizedBox(height: 10),
              ButtonBar(
                buttonPadding: EdgeInsets.all(0),
                alignment: showVideo
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.center,
                children: <Widget>[
                  RoundButton(
                    buttonText: 'All Decks',
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      Navigator.pop(context);
                    },
                  ),
                  if (showVideo)
                    RoundButton(
                      buttonText: 'Save Video',
                      isFocused: true,
                      onPressed: () async {
                        HapticFeedback.mediumImpact();

                        await Permission.photos.request();

                        if (await Permission.photos.isGranted) {
                          GallerySaver.saveVideo(videoFilePath).then(
                              (_) => _buildFlushBar('Video Saved!', context));
                        } else {
                          _buildFlushBar('Video not saved!', context);
                        }
                      },
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
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
