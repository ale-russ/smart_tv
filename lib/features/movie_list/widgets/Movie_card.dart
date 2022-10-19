import 'dart:math';
import 'dart:ui';

//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/services/keys.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/movie_list/widgets/description.dart';

import '../../../config/intentFiles/button_intents.dart';
import '../controller/movie_controller.dart';

class Movie_card extends StatelessWidget {
  Movie_card({Key? key}) : super(key: key);

  MoviesController _moviesController = Get.find();
  GlobalController _globalController = Get.find();
  IntentController _intentController = Get.find();

  CommonKeys movieUrl = Get.put(CommonKeys());

  Random random = Random();
  int index = 0;
  double heightSize = 0;
  double widthSize = 0;
  int currentPage = 0;

  void getRandom() async {
    index = random.nextInt(_moviesController.topratedmovies.length);
  }

  @override
  Widget build(BuildContext context) {
    getRandom();
    heightSize = MediaQuery.of(context).size.height * 0.8;
    widthSize = MediaQuery.of(context).size.width;
    //print(heightSize);
    //print(controller.topratedmovies[index]);
    return InkWell(
        onTap: () {
          _moviesController.currentPage.value == 1
              ? _moviesController.currentPage.value = 0
              : _moviesController.currentPage.value = 1;
        },
        child: FocusableActionDetector(
          focusNode: _moviesController.posterNodes!.value[0],
          shortcuts: _globalController.navigationIntents,
          actions: <Type, Action<Intent>>{
            DownbuttonIntent:
                CallbackAction<DownbuttonIntent>(onInvoke: (intent) {
              moveDown(context);
            }),
            LeftbuttonIntent:
                CallbackAction<LeftbuttonIntent>(onInvoke: (intent) {
              print("left  ");
              moveLeft(context);
            }),
            RightbuttonIntent:
                CallbackAction<RightbuttonIntent>(onInvoke: (intent) {
              moveRight(context);
            }),
          },
          child: MovieCardWithDescription(
              intentController: _intentController,
              movieUrl: movieUrl,
              moviesController: _moviesController,
              index: index,
              widthSize: widthSize,
              heightSize: heightSize,
              currentPage: currentPage),
        ));
  }

  void moveRight(BuildContext context) {
    if (_intentController.posterIndex == 0) {
      _moviesController.currentPage.value == 1
          ? _moviesController.currentPage.value = 0
          : _moviesController.currentPage.value = 1;
    } // else while(_intentController.posterIndex<3) {
    //   FocusScope.of(context).requestFocus(_intentController
    //       .posterNodes!.value[++_intentController.posterIndex]);
    //   _intentController.posterNodes!.refresh();
    // }
  }

  void moveDown(BuildContext context) {
    FocusScope.of(context)
        .requestFocus(_moviesController.trendingNodes!.value[0]);
    _moviesController.trendingNodes!.refresh();
    _moviesController.posterNodes!.refresh();
    _intentController.trendingIndex = 0;
    _intentController.trendingScrollController.value.animateTo(0,
        duration: const Duration(milliseconds: 800), curve: Curves.ease);
    //  else {
    //   FocusScope.of(context)
    //       .requestFocus(_intentController.trendingNodes!.value[0]);
    //   _intentController.trendingNodes!.refresh();
    // }
  }

  void moveLeft(BuildContext context) {
    // if (_intentController.posterIndex > 0) {
    //   FocusScope.of(context).requestFocus(_intentController
    //       .posterNodes!.value[--_intentController.posterIndex]);
    //   _intentController.posterNodes!.refresh();
    // } else {
    print("left in ");
    FocusScope.of(context).requestFocus(_moviesController.sideNodes![0]);
    _moviesController.posterNodes!.refresh();
    _moviesController.sideNodes!.refresh();
    //_intentController.searchNode.refresh();
    // }
  }
}

class MovieCardWithDescription extends StatelessWidget {
  const MovieCardWithDescription({
    Key? key,
    required this.movieUrl,
    required this.moviesController,
    required this.index,
    required this.widthSize,
    required this.heightSize,
    required this.currentPage,
    required this.intentController,
  }) : super(key: key);

  final CommonKeys movieUrl;
  final MoviesController moviesController;
  final int index;
  final IntentController intentController;
  final double widthSize;
  final double heightSize;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        child: Obx(
          () => Container(
            margin: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
              border: !moviesController.posterNodes!.value[0].hasFocus
                  ? Border.all(color: Colors.grey.withOpacity(0.3))
                  : Border.all(color: PrimaryColorTones.mainColor),
              image: DecorationImage(
                image: NetworkImage(
                  "${movieUrl.movieUrl}${moviesController.topratedmovies[index]['backdrop_path']}",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: moviesController.currentPage == 1
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: !moviesController
                                  .posterNodes!.value[0].hasFocus
                              ? Border.all(
                                  width: 1, color: PrimaryColorTones.mainColor)
                              : Border.all(color: Colors.grey.withOpacity(0.3)),
                          // border: Border.all(color: Colors.amber),
                          color: Colors.black.withOpacity(0.6)),
                    ),
                  )
                : null,
          ),
        ),
      ),
      PlayWatchButton(widthSize: widthSize, heightSize: heightSize),
      Obx(
        () => moviesController.currentPage == 1
            ? Positioned(
                top: 100,
                left: 30,
                child: MovieInfo(controller: moviesController, index: index))
            : Container(),
      ),
      Obx(
        () => moviesController.currentPage == 1
            ? Positioned(
                top: 30,
                left: 430,
                child: MovieSummary(controller: moviesController, index: index))
            : Container(),
      ),
      Positioned(
          bottom: 30,
          right: 30,
          child: Container(
            width: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Container(
                    width: moviesController.currentPage == 0 ? 20 : 10,
                    height: 10,
                    child: Divider(
                      color: moviesController.currentPage == 0
                          ? Color(0xFFFFA500)
                          : Colors.white,
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                    width: moviesController.currentPage == 1 ? 20 : 10,
                    height: 10,
                    child: Divider(
                      color: moviesController.currentPage == 1
                          ? Color(0xFFFFA500)
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ))
    ]);
  }
}

class PlayWatchButton extends StatelessWidget {
  PlayWatchButton({
    Key? key,
    required this.widthSize,
    required this.heightSize,
  }) : super(key: key);

  final double widthSize;
  final double heightSize;

  CommonKeys movieUrl = Get.find();
  MoviesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30,
      bottom: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffffa600),
              fixedSize: Size(widthSize * 0.14, heightSize * 0.075),
            ),
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  size: 20,
                ),
                Text(
                  "Play".tr,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              fixedSize: Size(widthSize * 0.14, heightSize * 0.075),
              side: const BorderSide(
                color: Color(0xffffa600),
              ),
            ),
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  size: 20,
                ),
                Text(
                  "Watch Trailer".tr,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieSummary extends StatelessWidget {
  const MovieSummary({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final MoviesController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width * 0.40,
        //color: Colors.black45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Plot Summary".tr,
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
            Text(
              controller.trendingmovies[index]["overview"],
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                  fontSize: 9, color: const Color(0xFFFFFFFF).withOpacity(0.6)),
            ),
            Text(
              "Cast & Crew ".tr,
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  CircularAvatar(),
                  CircularAvatar(),
                  CircularAvatar(),
                  CircularAvatar(),
                  CircularAvatar(),
                  CircularAvatar()
                ])
          ],
        ));
  }
}

class CircularAvatar extends StatelessWidget {
  const CircularAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: const Color(0xFFFFA500)),
                borderRadius: BorderRadius.circular(100)),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Artist Role".tr,
            style: TextStyle(
                fontSize: 9, color: const Color(0xFFFFFFFF).withOpacity(0.6)),
          )
        ],
      ),
    );
  }
}

class MovieInfo extends StatelessWidget {
  MovieInfo({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final MoviesController controller;
  final int index;
  double star_rating = 0;

  @override
  Widget build(BuildContext context) {
    star_rating = controller.topratedmovies[index]['vote_average'].toInt() / 2;
    print(star_rating.round());
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //"honor student with a perfect score on the entrance",
            controller.topratedmovies[index]['title'.tr],
            // overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 15,
            child: Row(
              children: [
                Text(
                  controller.topratedmovies[index]['release_date'.tr]
                      .toString()
                      .substring(0, 4),
                  //"2021 ",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const VerticalDivider(
                  color: Colors.white,
                  // thickness: 6,
                  // width: 5,
                ),
                Text(
                  "Kabbee ".tr,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const VerticalDivider(
                  color: Colors.white,
                ),
                Text(
                  controller.topratedmovies[index]['original_language'.tr]
                      .toString()
                      .toUpperCase(),
                  //"tigrinia",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const VerticalDivider(
                  color: Colors.white,
                ),
                Text(
                  "1 hr 30 min".tr,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(
                    star_rating >= 1 ? Icons.star : Icons.star_border_outlined,
                    size: 16,
                    color: const Color(0xFFFFA500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(
                    star_rating >= 2 ? Icons.star : Icons.star_border_outlined,
                    size: 16,
                    color: const Color(0xFFFFA500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(
                    star_rating >= 3 ? Icons.star : Icons.star_border_outlined,
                    size: 16,
                    color: const Color(0xFFFFA500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(
                    star_rating >= 4 ? Icons.star : Icons.star_border_outlined,
                    size: 16,
                    color: const Color(0xFFFFA500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(
                    star_rating >= 5 ? Icons.star : Icons.star_border_outlined,
                    size: 16,
                    color: const Color(0xFFFFA500),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
