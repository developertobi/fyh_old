import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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

      print('Aspect ratio: ${_videoPlayerController.value.aspectRatio}');

      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
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
            height: (MediaQuery.of(context).size.width),
            margin: EdgeInsets.all(0),
            child: GestureDetector(
              onTap: () {
                if (_videoPlayerController.value.isPlaying) {
                  _videoPlayerController.pause();
                }
                setState(() {});
              },
              child: Stack(
                children: _videoPlayerController.value.initialized
                    ? <Widget>[
                        AspectRatio(
                          // Android's aspect ration is inverse of iphone
                          aspectRatio: Platform.isAndroid
                              ? 1 / _videoPlayerController.value.aspectRatio
                              : _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController),
                        ),
                        if (!_videoPlayerController.value.isPlaying)
                          Positioned.fill(
                            child: Center(
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: IconButton(
                                  onPressed: () {
                                    _videoPlayerController.play();
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    FontAwesome5Solid.play,
                                    color: Colors.black,
                                    size: 60,
                                  ),
                                ),
                              ),
                            ),
                          )
                      ]
                    : <Widget>[Container()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
