import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/config/intentFiles/button_intents.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/video_player/controller/video_controller.dart';
import 'package:video_player/video_player.dart';

import '../../common/controller/intent_controllers.dart';

//void main() => runApp(const VideoApp());

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatelessWidget {
  VideoApp({Key? key}) : super(key: key);

  final VideoController _videoController = Get.put(VideoController());

  final IntentController _intentController = Get.find();

  final GlobalController _globalController = Get.find();

  // _changeNodeFocus(BuildContext build, String direction) {
  @override
  Widget build(BuildContext context) {
    // print("aspectRatio is ${_controller!.value.aspectRatio}");
    print(" focused" + FocusScope.of(context).focusedChild.toString());
    _videoController.initializeNode();
    print("videoNode");
    // if (!_intentController.videoPlayerNodes!.value[0].hasFocus) {
    //   // _setFirstFocus();
    // }
    return Scaffold(
      backgroundColor: DarkModeColors.backgroundColor,
      body: FocusableActionDetector(
        shortcuts: _globalController.navigationIntents,
        actions: <Type, Action<Intent>>{
          DownbuttonIntent:
              CallbackAction<DownbuttonIntent>(onInvoke: (intent) {
            if (_intentController.videoIndex == 0) {
              FocusScope.of(context).requestFocus(_intentController
                  .videoPlayerNodes!.value[_intentController.videoIndex]);
              _intentController.videoPlayerNodes!.refresh();
            }
            // moveDown(context);
          }),
          LeftbuttonIntent:
              CallbackAction<LeftbuttonIntent>(onInvoke: (intent) {
            //moveLeft(context);
            print("video player here i come");
          }),
          RightbuttonIntent:
              CallbackAction<RightbuttonIntent>(onInvoke: (intent) {
            //moveRight(context);
          }),
          UpbuttonIntent: CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
            // moveUp(context);
          })
        },
        child: SingleChildScrollView(
          child: Container(
            height: Get.height,
            child: !_videoController.controller!.value.isInitialized
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
                        if (_videoController
                            .controller!.value.isInitialized) ...[
                          // change here
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 2,
                              // aspectRatio: _controller!.value.aspectRatio,
                              child: SizedBox(
                                width: double.infinity,
                                child:
                                    VideoPlayer(_videoController.controller!),
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
                            color:
                                DarkModeColors.backgroundVariant.withAlpha(150),
                          ),
                          child: Obx(
                            () => IconButton(
                                // focusNode: _intentController
                                //     .videoPlayerNodes!.value[0],
                                icon: FocusableActionDetector(
                                  child: Icon(
                                    _videoController.controller!.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: _videoController
                                            .videoPlayerNodes!.value[0].hasFocus
                                        ? Colors.amber
                                        : Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  // setState(() {
                                  _videoController.controller!.value
                                          .isPlaying //change here too
                                      ? _videoController.controller!.pause()
                                      : _videoController.controller!.play();
                                  // });
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
                            _videoController.controller!,
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
                                  focusNode:
                                      _videoController.videoPlayerNodes![1],
                                  child: Icon(
                                    Icons.skip_previous,
                                    color: Colors.white,
                                    // color: Colors.white,
                                  ),
                                ),
                                Focus(
                                  focusNode:
                                      _videoController.videoPlayerNodes![2],
                                  child: Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Focus(
                                  focusNode:
                                      _videoController.videoPlayerNodes![3],
                                  child: Icon(
                                    animatedvolumeicon(
                                        _videoController.volume.value),
                                    color: Colors.white,
                                  ),
                                ),
                                Slider(
                                    inactiveColor: Colors.grey,
                                    activeColor: Colors.orange,
                                    min: 0,
                                    max: 1,
                                    value: _videoController
                                        .volume.value, // volume,
                                    onChanged: (changevolume) {
                                      // setState(() {
                                      //   volume = changevolume;
                                      //   _controller!.setVolume(changevolume);
                                      // });
                                    }),
                                Text(
                                  '${convertToMinutesSeconds(_videoController.videopostion!.value)} / ${convertToMinutesSeconds(_videoController.videolength!.value)}',
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
