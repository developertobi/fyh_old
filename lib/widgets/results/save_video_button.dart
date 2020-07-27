import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:naija_charades/widgets/shared/round_button.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveVideoButton extends StatelessWidget {
  final String videoFilePath;

  const SaveVideoButton(this.videoFilePath);

  @override
  Widget build(BuildContext context) {
    return RoundButton(
      width: (MediaQuery.of(context).size.width - 70) / 2,
      onPressed: () async {
        HapticFeedback.mediumImpact();

        await Permission.photos.request();

        if (await Permission.photos.isGranted) {
          GallerySaver.saveVideo(videoFilePath)
              .then((_) => _buildFlushBar('Video Saved!', context));
        } else {
          _buildFlushBar('Video not saved!', context);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.save_alt,
            size: 30,
          ),
          SizedBox(width: 5),
          Text(
            'Save Video',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
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
