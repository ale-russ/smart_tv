import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/services/keys.dart';
import 'package:smart_tv/features/common/theme/text_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/widgets/description.dart';

import '../../../config/intentFiles/button_intents.dart';

class MoviesTile extends StatefulWidget {
  MoviesTile(
      {Key? key,
      required this.title,
      required this.movie,
      required this.nodes,
      required this.borderColor,
      required this.scrollController,
      this.onSearch = false})
      : super(key: key);

  final onSearch;
  final String? title;
  final List? movie;
  final RxList? nodes;
  final Color borderColor;
  final ScrollController scrollController;

  @override
  State<MoviesTile> createState() => _MoviesTileState();
}

class _MoviesTileState extends State<MoviesTile> {
  Color textColor = Colors.white;

  MoviesController controller = Get.put(MoviesController());

  final IntentController _intentController = Get.find();

  final CommonKeys _commonKeys = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ModifiedText(
          text: widget.title!,
          size: 18,
          color: textColor,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            controller: widget.scrollController,
            itemCount: widget.movie!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  _intentController.desc = true;
                  // _intentController.unFocus();
                  Get.to(() => Description(
                        bannerurl:
                            "${_commonKeys.movieUrl}${widget.movie![index]['backdrop_path']}",
                        description: widget.movie![index]['overview'],
                        lauchOn: widget.movie![index]['release_date'] ?? "",
                        name: widget.movie![index]['title'] ?? "",
                        posterurl:
                            "${_commonKeys.movieUrl}${widget.movie![index]['backdrop_path']}",
                        vote: widget.movie![index]['vote_average'].toString(),
                      ));
                },
                child: widget.movie!.isNotEmpty
                    ? Obx(
                        () => Container(
                          padding: const EdgeInsets.only(right: 5),
                          width: 205,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Focus(
                                focusNode: widget.nodes![index],
                                child: Container(
                                  width: 200,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: widget.nodes!.value[index].hasFocus
                                        ? Border.all(color: Colors.amber)
                                        : Border.all(color: widget.borderColor),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "${_commonKeys.movieUrl}${widget.movie![index]['poster_path']}",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: ModifiedText(
                                  text: widget.movie![index]['title'] ??
                                      'Loading',
                                  color: Colors.white,
                                  size: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
              );
            },
          ),
        )
      ],
    );
  }
}

class ComingSoon extends StatefulWidget {
  ComingSoon({Key? key, this.movie}) : super(key: key);
  final List? movie;

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  MoviesController controller = Get.find();
  final IntentController _intentController = Get.find();
  final GlobalController _globalController = Get.find();
  final CommonKeys _commonKeys = Get.find();
  @override
  void initState() {
    if (_intentController.comingNodes!.isEmpty) {
      for (var i = 0; i < controller.trendingmovies.length; i++) {
        var temp = FocusNode();
        _intentController.comingNodes!.add(temp);
      }
    }
    super.initState();
  }

  int? count;

  MoviesController mController = Get.put(MoviesController());
  //IntentController _intentController = Get.find();

  User? user;

  @override
  Widget build(BuildContext context) {
    print("width is ${Get.width}");
    if (MediaQuery.of(context).size.width < 650) {
      count = 2;
    } else if (MediaQuery.of(context).size.width > 1100) {
      count = 4;
    } else {
      count = 3;
    }
    return Scaffold(
      backgroundColor: DarkModeColors.backgroundColor,
      appBar: GetPlatform.isDesktop
          ? AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      body: FocusableActionDetector(
        shortcuts: _globalController.navigationIntents,
        actions: <Type, Action<Intent>>{
          UpbuttonIntent: CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
            if (_intentController.comingIndex - 3 > 0) {
              FocusScope.of(context).requestFocus(_intentController
                  .comingNodes![_intentController.comingIndex - 3]);
              _intentController.comingIndex = _intentController.comingIndex - 3;
              _intentController.comingNodes!.refresh();
              _intentController.comingPageScrollController.value.animateTo(
                  _intentController.comingPageScrollController.value.offset -
                      Get.height * 0.5,
                  // 180,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.ease);
            } else {
              FocusScope.of(context)
                  .requestFocus(_intentController.comingNodes![0]);
              _intentController.comingIndex = 0;
              _intentController.comingNodes!.refresh();
            }
            // moveUp(context);
          }),
          DownbuttonIntent:
              CallbackAction<DownbuttonIntent>(onInvoke: (intent) {
            if (_intentController.comingIndex + 3 <
                _intentController.comingNodes!.length) {
              FocusScope.of(context).requestFocus(_intentController
                  .comingNodes![_intentController.comingIndex + 3]);
              _intentController.comingIndex = _intentController.comingIndex + 3;
              _intentController.comingNodes!.refresh();
              _intentController.comingPageScrollController.value.animateTo(
                  _intentController.comingPageScrollController.value.offset +
                      Get.height * 0.5,
                  // 200,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.ease);
              // moveDown(context);
            }
          }),
          LeftbuttonIntent:
              CallbackAction<LeftbuttonIntent>(onInvoke: (intent) {
            print("Left index in comming is ${mController.sideNodes!.value}");
            if (_intentController.comingIndex % 3 == 0) {
              FocusScope.of(context).requestFocus(mController.sideNodes![0]);
              _intentController.comingIndex = 0;
              _intentController.comingNodes!.refresh();
              mController.sideNodes!.refresh();
            } else {
              if (_intentController.comingIndex > 0) {
                FocusScope.of(context).requestFocus(_intentController
                    .comingNodes![--_intentController.comingIndex]);

                _intentController.comingNodes!.refresh();
              }
            }
            // moveLeft(context);
          }),
          RightbuttonIntent:
              CallbackAction<RightbuttonIntent>(onInvoke: (intent) {
            if (_intentController.comingIndex <
                mController.trendingmovies.length - 1) {
              FocusScope.of(context).requestFocus(_intentController
                  .comingNodes![_intentController.comingIndex + 1]);
              _intentController.comingIndex++;
              _intentController.comingNodes!.refresh();
            }
            //moveRight(context);
          }),
        },
        child: Container(
          decoration: BoxDecoration(
            color: DarkModeColors.backgroundColor,
          ),
          child: GridView.builder(
            controller: _intentController.comingPageScrollController.value,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: count!,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: widget.movie!.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => Description(
                              bannerurl:
                                  "${_commonKeys.movieUrl}${widget.movie![index]['backdrop_path']}",
                              description:
                                  widget.movie![index]['overview'] ?? "",
                              lauchOn:
                                  widget.movie![index]['release_date'] ?? "",
                              name: widget.movie![index]['title'] ?? "",
                              posterurl:
                                  "${_commonKeys.movieUrl}${widget.movie![index]['country']}",
                              vote: widget.movie![index]['vote_average']
                                  .toString(),
                            )),
                      ),
                    );
                  },
                  child: Obx(
                    () => Focus(
                      focusNode: _intentController.comingNodes![index],
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: _intentController
                                          .comingNodes![index].hasFocus
                                      ? Border.all(color: Colors.amber)
                                      : Border.all(
                                          color: Colors.grey.withOpacity(0.3)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "${_commonKeys.movieUrl}${widget.movie![index]['poster_path']}",
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              child: KabbeeText.headline6(
                                widget.movie![index]['title'] ?? "Loading",
                                customStyle: TextStyle(
                                    color: Colors.white.withAlpha(255)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
