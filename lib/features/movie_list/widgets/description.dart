import 'dart:developer';

import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/widgets/video_palyer_page.dart';
import 'package:video_player/video_player.dart';

import '../../../config/intentFiles/button_intents.dart';
import '../../common/theme/icon_themes.dart';
import '../../common/theme/themes.dart';

class Description extends StatefulWidget {
  final String name, description, bannerurl, posterurl, vote, lauchOn;

  const Description({
    Key? key,
    required this.bannerurl,
    required this.description,
    required this.lauchOn,
    required this.name,
    required this.posterurl,
    required this.vote,
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
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
                          // fit: BoxFit.fill,
                        ),
                      ),
                      // child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.orange,
                                        minimumSize: Size(150, 40),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => VideoApp()),
                                        );
                                      },
                                      icon: KabbeeIcons.play(
                                          color:
                                              DarkModeColors.backgroundVariant,
                                          size: 25),
                                      label: Text(
                                        'Play',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      )),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: DarkModeColors.backgroundVariant
                                          .withOpacity(0.1),
                                      minimumSize: Size(150, 40),
                                    ),
                                    onPressed: () {},
                                    icon: KabbeeIcons.play(
                                      // color: DarkModeColors.backgroundVariant,
                                      size: 25,
                                    ),
                                    label: Text(
                                      'Watch Later',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ))
                              ]),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(widget.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MovieInfo(
                        lauchOn: widget.lauchOn,
                        movieLanguage: "Tigrigna",
                        producer: "Kabbee",
                        duration: "1 hr 25 min",
                        title: widget.name,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: PlotSummary(
                          descritpion: widget.description,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Cast & Crew',
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 120,
                            width: 300,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) => CastCrew(),
                            ),
                          )
                        ],
                      ),
                      Center(
                          child: Trailers(
                        banneerUrl: widget.bannerurl,
                      ))
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

class MovieInfo extends StatelessWidget {
  MovieInfo(
      {Key? key,
      this.lauchOn,
      this.movieLanguage,
      this.producer,
      this.duration,
      this.title})
      : super(key: key);

  final String? lauchOn;
  final String? movieLanguage;
  final String? producer;
  final String? duration;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title!,
            style: TextStyle(color: Colors.grey, fontSize: 50),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8,
          ),
          child: RichText(
            text: TextSpan(
              // style: Theme.of(context).textTheme.subtitle2,
              style: TextStyle(color: Colors.grey),
              children: <TextSpan>[
                TextSpan(text: lauchOn),
                TextSpan(text: "  |  "),
                TextSpan(text: producer),
                TextSpan(text: "  |  "),
                TextSpan(text: movieLanguage),
                TextSpan(text: "  |  "),
                TextSpan(text: duration)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              for (var i = 0; i < 5; i++)
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
              SizedBox(
                width: 10,
              ),
              Text(
                '(5 Review)',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              )
            ],
          ),
        )
      ],
    );
  }
}

class PlotSummary extends StatelessWidget {
  const PlotSummary({
    Key? key,
    this.descritpion,
  }) : super(key: key);

  final String? descritpion;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(right: 10),
      width: Get.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Plot sumary',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: Get.width,
              child: Text(
                // textAlign: TextAlign.justify,
                maxLines: 3,

                overflow: TextOverflow.ellipsis,
                descritpion!,
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class Trailers extends StatelessWidget {
  Trailers({Key? key, this.banneerUrl}) : super(key: key);

  String? banneerUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Traillers',
          style: TextStyle(color: Colors.grey, fontSize: 20),
        ),
        Row(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(banneerUrl!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        banneerUrl!,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            ],
          )
        ])
      ],
    );
  }
}

class CastCrew extends StatelessWidget {
  const CastCrew({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: PrimaryColorTones.mainColor)),
            child: CircleAvatar(
                // backgroundColor: PrimaryColorTones.mainColor,
                radius: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Artist',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            'Role',
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
