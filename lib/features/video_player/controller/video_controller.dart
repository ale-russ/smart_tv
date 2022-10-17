//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  VideoPlayerController? controller;
  Rx<Duration>? videolength = Rx(Duration());
  Rx<Duration>? videopostion = Rx(Duration());
  RxList<dynamic>? videoPlayerNodes = [].obs;
  RxDouble volume = 0.0.obs;
  RxBool videoInitialised = false.obs;

  @override
  void onInit() {
    print("onint  initialilsed ");
    try {
      controller = VideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
        ..addListener(() {
          videopostion!.value = controller!.value.position;
          print("initialize the position");
        })
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          //initializeNode();
          initializeNode();
          print("player initialilsed ");
          videoInitialised.value = true;
          videolength!.value = controller!.value.position;
        });
    } on Exception catch (e) {
      print(" the error " + e.toString());
      // TODO
    }
    // TODO: implement onInit
    super.onInit();
  }

  initializeNode() {
    for (var i = 0; i < 4; i++) {
      videoPlayerNodes!.add(FocusNode(debugLabel: "video Node $i"));
      //print(videoPlayerNodes![i]);
      videoPlayerNodes!.refresh();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    controller!.dispose();
  }
}
