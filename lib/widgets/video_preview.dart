import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  final String videoFilePath;
  VideoPreview(this.videoFilePath);

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.videoFilePath));

    _videoPlayerController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _videoPlayerController.setLooping(true);
      _videoPlayerController.play();

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // height: 250,
        child: RotatedBox(
          quarterTurns: 3,
          child: Container(
            height: 250,
            margin: EdgeInsets.all(0),
            child: _videoPlayerController.value.initialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                : Container(),
          ),
        ),
      ),
    );
  }
}

// Container(
//         height: 250,
//         decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.white30),
//         ),
//         child: RotatedBox(
//           quarterTurns: 3,
//           child: Container(
//             margin: EdgeInsets.all(0),
//             child: _videoPlayerController.value.initialized
//                 ? AspectRatio(
//                     aspectRatio: _videoPlayerController.value.aspectRatio,
//                     child: VideoPlayer(_videoPlayerController),
//                   )
//                 : Container(),
//           ),
//         ))
