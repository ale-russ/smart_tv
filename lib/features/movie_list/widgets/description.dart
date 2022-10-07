import 'dart:developer';

import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:video_player/video_player.dart';

import '../../../config/intentFiles/button_intents.dart';

class Description extends StatefulWidget {
  final String name, description, bannerurl, posterurl, vote, lauchOn;

  const Description(
      {Key? key,
      required this.bannerurl,
      required this.description,
      required this.lauchOn,
      required this.name,
      required this.posterurl,
      required this.vote})
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  // late VideoPlayerController _videoPlayerController;

  final IntentController _intentController = Get.find();

  final MoviesController moviesController = Get.find();

  MoviesController controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _videoPlayerController.dispose();
    _intentController.desc = false;
  }

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
  Widget build(BuildContext context) {
    if (moviesController.serverMessage.isNotEmpty) {
      return Container(
        child: const Text("Content Not Found"),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GetPlatform.isDesktop || GetPlatform.isWeb
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : const SizedBox.shrink(),
      ),
      backgroundColor: Colors.black,
      body: Shortcuts(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowRight): RightbuttonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftbuttonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowUp): UpbuttonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown): DownbuttonIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                onInvoke: (intent) => _changeNodeFocus(context, "Down")),
            UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                onInvoke: (inteent) => _changeNodeFocus(context, "Up")),
            RightbuttonIntent: CallbackAction<RightbuttonIntent>(
                onInvoke: (intent) => _changeNodeFocus(context, "Right")),
            LeftbuttonIntent: CallbackAction<LeftbuttonIntent>(
                onInvoke: (intent) => _changeNodeFocus(context, "Left")),
          },
          child: ListView(
            controller: _intentController.descPageScrollController,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 100,
                        bottom: MediaQuery.of(context).size.height * 0.3,
                        child: Focus(
                          focusNode: _intentController.descNodes![0],
                          child: IconButton(
                            icon: Icon(
                              Icons.play_circle_fill_rounded,
                              color: _intentController.descNodes![0].hasFocus
                                  ? Colors.amber
                                  : Colors.white,
                              size: 100,
                            ),
                            onPressed: () async {
                              // _videoPlayerController.value.isPlaying
                              //     ? _videoPlayerController.pause()
                              //     : _videoPlayerController.play();
                              // log("Video is ${_videoPlayerController.value}");
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        child: Focus(
                          focusNode: _intentController.descNodes![1],
                          child: ModifiedText(
                              text: '⭐Average Rating - ${widget.vote}',
                              color: _intentController.descNodes![1].hasFocus
                                  ? Colors.amber
                                  : Colors.white60,
                              size: 20),
                        ),
                      ),
                    ],
                  )),
              Focus(
                focusNode: _intentController.descNodes![2],
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: ModifiedText(
                      text: widget.name, color: Colors.white60, size: 15),
                ),
              ),
              Focus(
                focusNode: _intentController.descNodes![3],
                child: Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: ModifiedText(
                      text: 'Releasing On - ${widget.lauchOn}',
                      color: Colors.white60,
                      size: 15),
                ),
              ),
              Focus(
                focusNode: _intentController.descNodes![4],
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      height: 200,
                      width: 100,
                      child: Image.network(widget.posterurl),
                    ),
                    Flexible(
                      child: SizedBox(
                        child: ModifiedText(
                            text: widget.description,
                            color: Colors.white60,
                            size: 15),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
