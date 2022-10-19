import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/services/keys.dart';
import 'package:smart_tv/features/common/theme/text_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/widgets/description.dart';
import 'package:smart_tv/features/movie_list/widgets/movies_tile.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../../config/intentFiles/button_intents.dart';

class Library extends StatelessWidget {
  Library({super.key});

  MoviesController _moviesController = Get.put(MoviesController());
  GlobalController _globalController = Get.find();
  IntentController _intentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkModeColors.backgroundColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            LibraryTile(
              nodes: _moviesController.comingNodes!,
              movies: _moviesController.trendingmovies,
              label: "History".tr,
            ),
            SizedBox(
              height: 40,
            ),
            LibraryTile(
              nodes: _moviesController.favNodes!,
              // nodes: _intentController.comingNodes!,
              movies: _moviesController.trendingmovies,
              label: "Watch Later".tr,
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryTile extends StatelessWidget {
  LibraryTile(
      {Key? key,
      required this.movies,
      required this.label,
      required this.nodes})
      : super(key: key);

  List? movies;
  String? label;
  RxList? nodes;

  CommonKeys _movieUrl = Get.put(CommonKeys());

  GlobalController _globalController = Get.find();

  final CommonKeys _commonKeys = Get.find();

  IntentController _intentController = Get.find();

  MoviesController _movieController = Get.find();

  // void initState() {
  @override
  Widget build(BuildContext context) {
    print("Movies are ${movies!.length}");

    return FocusableActionDetector(
      shortcuts: _globalController.navigationIntents,
      actions: <Type, Action<Intent>>{
        DownbuttonIntent: CallbackAction<DownbuttonIntent>(onInvoke: (intent) {
          // moveDown(context);
          moveDown(context);
        }),
        LeftbuttonIntent: CallbackAction<LeftbuttonIntent>(onInvoke: (intent) {
          moveLeft(context);
          //moveLeft(context);
        }),
        RightbuttonIntent:
            CallbackAction<RightbuttonIntent>(onInvoke: (intent) {
          moveRight(context);
          // moveRight(context);
        }),
        UpbuttonIntent: CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
          FocusScope.of(context).requestFocus(_movieController.comingNodes![0]);
          // _intentController.coming = true;
          _movieController.favNodes!.refresh();
          _movieController.comingNodes!.refresh();
          _intentController.favIndex = 0;
          //moveUp(context);
        })
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: KabbeeText.subtitle1(
                    label!,
                    customStyle: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: TextButton(
                    child: KabbeeText.subtitle1(
                      "see_all".tr,
                      customStyle:
                          TextStyle(color: PrimaryColorTones.mainColor),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComingSoon(
                            movie: movies,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              // width: 100,
              height: 140,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: movies!.length,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    print("index in Library is $index");
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Description(
                                      bannerurl:
                                          '${_commonKeys.movieUrl}${movies![index]['backdrop_path']}',
                                      description: movies![index]['overview'],
                                      lauchOn:
                                          movies![index]['release_date'] ?? "",
                                      name: movies![index]['title'] ?? "",
                                      posterurl:
                                          '${_commonKeys.movieUrl}${movies![index]['backdrop_path']}',
                                      vote: movies![index]['vote_average']
                                          .toString(),
                                    ))));
                      },
                      child: Focus(
                        focusNode: nodes![index],
                        child: Obx(
                          () => Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: 200,
                            height: 140,
                            decoration: BoxDecoration(
                                border: nodes![index]!.hasFocus
                                    ? Border.all(color: Colors.amber)
                                    : Border.all(
                                        color: DarkModeColors.borderColor),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "${_movieUrl.movieUrl}${movies![index]['backdrop_path']}",
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  void moveLeft(BuildContext context) {
    print("left");
    if (_intentController.coming) {
      if (_intentController.comingIndex <= 0) {
        FocusScope.of(context).requestFocus(_movieController.sideNodes![0]);
        _movieController.sideNodes!.refresh();
      } else {
        FocusScope.of(context).requestFocus(
            _movieController.comingNodes![--_intentController.comingIndex]);
        _movieController.comingNodes!.refresh();
        // _intentController.sideNodes!.refresh();
        // _intentController.trendingScrollController.value.animateTo(
        //     _intentController.trendingScrollController.value.offset - 230,
        //     curve: Curves.ease,
        //     duration: Duration(milliseconds: 800));
        //_intentController.comingIndex--;
      }
    } else {
      if (_intentController.favIndex <= 0) {
        FocusScope.of(context).requestFocus(_movieController.sideNodes![0]);
        _movieController.sideNodes!.refresh();
      } else {
        FocusScope.of(context).requestFocus(
            _movieController.favNodes![--_intentController.favIndex]);
        _movieController.favNodes!.refresh();

        // _intentController.trendingScrollController.value.animateTo(
        //     _intentController.trendingScrollController.value.offset - 230,
        //     curve: Curves.ease,
        //     duration: Duration(milliseconds: 800));
        //_intentController.favIndex--;
      }
    }
    _movieController.sideNodes!.refresh();
    _movieController.comingNodes!.refresh();
    _movieController.favNodes!.refresh();
  }

  void moveRight(BuildContext context) {
    print("right");
    if (_intentController.coming) {
      if (_intentController.comingIndex <
          _movieController.trendingmovies.length - 1) {
        FocusScope.of(context).requestFocus(
            _movieController.comingNodes![++_intentController.comingIndex]);
        print("right coming");
        // _intentController.comingPageScrollController.value.animateTo(
        //     _intentController.comingPageScrollController.value.offset + 230,
        //     curve: Curves.ease,
        //     duration: Duration(milliseconds: 800));
      }
    } else {
      if (_intentController.favIndex <
          _movieController.topratedmovies.length - 1) {
        FocusScope.of(context).requestFocus(
            _movieController.favNodes![++_intentController.favIndex]);

        // _intentController.comingPageScrollController.value.animateTo(
        //     _intentController.comingPageScrollController.value.offset + 230,
        //     curve: Curves.ease,
        //     duration: Duration(milliseconds: 800));
      }
    }
    _movieController.favNodes!.refresh();
    _movieController.comingNodes!.refresh();
  }

  void moveDown(BuildContext context) {
    // _intentController.comingPageScrollController.value.animateTo(0,
    //     duration: Duration(milliseconds: 800), curve: Curves.ease);
    FocusScope.of(context).requestFocus(_movieController.favNodes![0]);
    _movieController.favNodes!.refresh();
    _movieController.comingNodes!.refresh();
    _intentController.coming = false;
    //print("top");
    _intentController.comingIndex = 0;

    //trendingScrollController.jumpTo(5);
  }
}
