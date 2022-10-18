import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/config/intentFiles/button_intents.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:video_player/video_player.dart';

import '../../common/controller/intent_controllers.dart';

//void main() => runApp(const VideoApp());

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
  final GlobalController _globalController = Get.find();

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
    _controller = VideoPlayerController.
        // asset(
        //   "assets/big_buck_bunny.mp4",

        network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      // 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4',
    )
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

  _setFirstFocus() {
    if (!_intentController.videoPlayerNodes!.value[0].hasFocus) {
      print(
          "FocusNode on videoPlayer is ${!_intentController.videoPlayerNodes!.value[0].hasFocus}");
      // FocusScope.of(context)
      //     .requestFocus(_intentController.videoPlayerNodes!.value[0]);
      _intentController.videoPlayerNodes!.refresh();
      //print("play focus");
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("aspectRatio is ${_controller!.value.aspectRatio}");
    _setFirstFocus();
    return Scaffold(
      backgroundColor: DarkModeColors.backgroundColor,
      body: FocusableActionDetector(
        shortcuts: _globalController.navigationIntents,
        actions: _intentController.actionIntents(
            context: context,
            index: _intentController.videoIndex,
            nodes: _intentController.videoPlayerNodes),
        // <Type, Action<Intent>>{
        //   DownbuttonIntent:
        //       CallbackAction<DownbuttonIntent>(onInvoke: (intent) {
        //     if (_intentController.videoIndex == 0) {
        //       FocusScope.of(context).requestFocus(_intentController
        //           .videoPlayerNodes!.value[_intentController.videoIndex]);
        //       _intentController.videoPlayerNodes!.refresh();
        //     }
        //     // moveDown(context);
        //   }),
        //   LeftbuttonIntent:
        //       CallbackAction<LeftbuttonIntent>(onInvoke: (intent) {
        //     FocusScope.of(context).requestFocus(_intentController
        //         .videoPlayerNodes!.value[_intentController.videoIndex]);
        //     //moveLeft(context);
        //     print("video player here i come");
        //   }),
        //   RightbuttonIntent:
        //       CallbackAction<RightbuttonIntent>(onInvoke: (intent) {
        //     FocusScope.of(context).requestFocus(_intentController
        //         .videoPlayerNodes!.value[_intentController.videoIndex]);
        //     //moveRight(context);
        //   }),
        //   UpbuttonIntent: CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
        //     CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
        //       FocusScope.of(context).requestFocus(_intentController
        //           .videoPlayerNodes!.value[_intentController.videoIndex]);
        //     });
        //     // moveUp(context);
        //   })
        // },
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
                        child: Focus(
                          focusNode: _intentController.videoPlayerNodes![1],
                          // focusNode:
                          //     _intentController.videoPlayerNodes!.value[0],
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: DarkModeColors.backgroundVariant
                                  .withAlpha(150),
                            ),
                            child: IconButton(
                                // focusNode:
                                //     _intentController.videoPlayerNodes!.value[0],
                                icon: FocusableActionDetector(
                                  child: Icon(
                                    _controller!.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: _intentController
                                            .videoPlayerNodes!.value[0].hasFocus
                                        ? Colors.amber
                                        : Colors.white,
                                  ),
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
                               SizedBox(width: 15,),
                                Focus(
                                  focusNode:
                                      _intentController.videoPlayerNodes![1],
                                  child:IconButton( icon: Icon(Icons.replay_5_outlined,color: Colors.white,),onPressed: (){
                                    _controller!.seekTo(Duration (seconds: 1));
                                  },)
                                  
                                ),
                                SizedBox(width: 10,),
                                Focus(
                                  focusNode:
                                      _intentController.videoPlayerNodes![2],
                                  child: IconButton(icon:Icon(Icons.forward_5_rounded,color: Colors.white,),
                                  onPressed: (){
                                    _controller!.seekTo(Duration(seconds: _controller!.value.position.inSeconds + 1));
                                  },)
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Focus(
                                  focusNode:
                                      _intentController.videoPlayerNodes![3],
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
                                        _controller!.setVolume(changevolume);
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

