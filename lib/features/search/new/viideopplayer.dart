import 'dart:html';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoApp());

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController? _controller;
  Duration? videolength;
  Duration? videopostion;
  double volume = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..addListener(() {
        setState(() {
          videopostion = _controller!.value.position;
        });
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          videolength = _controller!.value.position;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            if (_controller!.value.isInitialized) ...[
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
              VideoProgressIndicator(
                _controller!,
                allowScrubbing: true,
                padding: EdgeInsets.all(10),
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        _controller!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                      onPressed: () {
                        setState(() {
                          _controller!.value.isPlaying
                              ? _controller!.pause()
                              : _controller!.play();
                        });
                      }),
                     Icon(Icons.skip_previous),
                      Icon(Icons.skip_next),

                     
                 
                      SizedBox(width: 15,),
                  Icon(animatedvolumeicon(volume)),
                  Slider(
                      inactiveColor: Color.fromARGB(255, 149, 147, 147),
                      activeColor: Colors.orange,
                      min: 0,
                      max: 1,
                      value: volume,
                      onChanged: (changevolume) {
                        setState(() {
                          volume = changevolume;
                          _controller!.setVolume(changevolume);
                        });
                      }),
                        Text(
                      '${convertToMinutesSeconds(videopostion!)}/${convertToMinutesSeconds(videolength!)}'),

                ],
              ),
              
            ]
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}

String convertToMinutesSeconds(Duration duration) {
  final parsedMinutes = duration.inMinutes % 60;

  final minutes =
      parsedMinutes < 10 ? '0$parsedMinutes' : parsedMinutes.toString();

  final parsedSeconds = duration.inSeconds % 60;
  final seconds =
      parsedSeconds < 10 ? '0${parsedSeconds}' : parsedSeconds.toString();

  return '$minutes:$seconds';
}

IconData animatedvolumeicon(double volume) {
  if (volume == 0)
    return Icons.volume_mute;
  else if (volume < 0.5)
    return Icons.volume_down;
  else
    return Icons.volume_up;
}
