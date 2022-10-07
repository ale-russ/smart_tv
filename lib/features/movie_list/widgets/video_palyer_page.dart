import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/config/intentFiles/button_intents.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:video_player/video_player.dart';

import '../../common/controller/intent_controllers.dart';

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

  final IntentController _intentController = Get.find();

  _changeNodeFocus(BuildContext build, String direction) {
    if (direction == "Down") {
      _intentController.DownNavActions(context);
      setState(() {});
    } else if (direction == "Up") {
      _intentController.UpNavActions(context);
      setState(() {});
    } else if (direction == "Right") {
      _intentController.RightNavActions(context);
      setState(() {});
    } else if (direction == "Left") {
      _intentController.LeftNavActions(context);
      setState(() {});
    }
  }

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
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("aspectRatio is ${_controller!.value.aspectRatio}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Demo',
      home: Scaffold(
        backgroundColor: DarkModeColors.backgroundColor,
        body: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowRight): RightbuttonIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftbuttonIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowDown): DownbuttonIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowUp): UpbuttonIntent(),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                onInvoke: (intent) => _changeNodeFocus(context, "Down"),
              ),
              UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                onInvoke: (intent) => _changeNodeFocus(context, "Up"),
              ),
              RightbuttonIntent: CallbackAction<RightbuttonIntent>(
                onInvoke: (intent) => _changeNodeFocus(context, "Right"),
              ),
              LeftbuttonIntent: CallbackAction<LeftbuttonIntent>(
                onInvoke: (intent) => _changeNodeFocus(context, "Left"),
              ),
            },
            child: SingleChildScrollView(
              child: Container(
                height: Get.height,
                child: !_controller!.value.isInitialized
                    //  videopostion == null
                    ? Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: PrimaryColorTones.mainColor,
                        ),
                      )
                    : Stack(
                        children: [
                          Column(children: [
                            if (_controller!.value.isInitialized) ...[
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 2,
                                  // aspectRatio: _controller!.value.aspectRatio,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: VideoPlayer(_controller!),
                                  ),
                                ),
                              ),
                            ]
                          ]),
                          Positioned(
                            top: Get.height * 0.5,
                            right: Get.width * 0.45,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: DarkModeColors.backgroundVariant
                                    .withAlpha(150),
                              ),
                              child: Focus(
                                focusNode:
                                    _intentController.videoPlayerNodes![0],
                                child: IconButton(
                                    icon: Icon(
                                      _controller!.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _controller!.value.isPlaying
                                            ? _controller!.pause()
                                            : _controller!.play();
                                      });
                                    }),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            child: Container(
                              width: Get.width,
                              height: 25,
                              child: VideoProgressIndicator(
                                _controller!,
                                allowScrubbing: true,
                                padding: EdgeInsets.all(10),
                                colors: VideoProgressColors(
                                  playedColor: PrimaryColorTones.mainColor,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 5,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Focus(
                                      focusNode: _intentController
                                          .videoPlayerNodes![0],
                                      child: Icon(
                                        Icons.skip_previous,
                                        color: Colors.white,
                                        // color: Colors.white,
                                      ),
                                    ),
                                    Focus(
                                      focusNode: _intentController
                                          .videoPlayerNodes![0],
                                      child: Icon(
                                        Icons.skip_next,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Focus(
                                      focusNode: _intentController
                                          .videoPlayerNodes![0],
                                      child: Icon(
                                        animatedvolumeicon(volume),
                                        color: Colors.white,
                                      ),
                                    ),
                                    Slider(
                                        inactiveColor: Colors.grey,
                                        activeColor: Colors.orange,
                                        min: 0,
                                        max: 1,
                                        value: volume,
                                        onChanged: (changevolume) {
                                          setState(() {
                                            volume = changevolume;
                                            _controller!
                                                .setVolume(changevolume);
                                          });
                                        }),
                                    Text(
                                      '${convertToMinutesSeconds(videopostion!)} / ${convertToMinutesSeconds(videolength!)}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
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
