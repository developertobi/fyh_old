import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:naija_charades/constants.dart';
import 'package:naija_charades/models/response.dart';
import 'package:naija_charades/providers/results.dart';
import 'package:naija_charades/providers/video_file.dart';
import 'package:naija_charades/widgets/game/video_preview.dart';
import 'package:naija_charades/widgets/results/close_button.dart';
import 'package:naija_charades/widgets/results/responses.dart';
import 'package:naija_charades/widgets/shared/round_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../colors.dart' as AppColors;

class ResultsDialog extends StatelessWidget {
  final bool showVideo;
  const ResultsDialog({@required this.showVideo});

  @override
  Widget build(BuildContext context) {
    final resultsProvider = Provider.of<Results>(context, listen: false);
    final videoFilePath = Provider.of<VideoFile>(context).path;

    return Dialog(
      backgroundColor: kTimeUpColor,
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
            child: Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'You answered ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: resultsProvider.score.toString(),
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: 'right!',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Responses(responses: resultsProvider.responses),
                ),
                const SizedBox(height: 10),
                if (showVideo) VideoPreview(videoFilePath),
                const SizedBox(height: 10),
                RoundButton(
                  width: 200,
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.loop,
                        size: 40,
                      ),
                      Text(
                        'Play Again',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
