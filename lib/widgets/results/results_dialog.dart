import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:naija_charades/constants.dart';
import 'package:naija_charades/models/response.dart';
import 'package:naija_charades/providers/results.dart';
import 'package:naija_charades/providers/video_file.dart';
import 'package:naija_charades/widgets/results/replay_button.dart';
import 'package:naija_charades/widgets/results/save_video_button.dart';
import 'package:naija_charades/widgets/results/video_preview.dart';
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
                  height: 70,
                  child: AspectRatio(
                      aspectRatio: kDeckCardAspectRatio,
                      child: Image.network(resultsProvider.deckImageUrl)),
                ),
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
                            SaveVideoButton(videoFilePath),
                            ReplayButton(),
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
}
