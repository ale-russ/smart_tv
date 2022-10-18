import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/intentFiles/button_intents.dart';
import '../../movie_list/controller/movie_controller.dart';

class IntentController extends GetxController {
  MoviesController _controller = Get.put(MoviesController());

  //ScrollController
  Rx<ScrollController> trendingScrollController = ScrollController().obs;
  Rx<ScrollController> searchScroller = ScrollController().obs;
  Rx<ScrollController> tvShowScrollController = ScrollController().obs;
  Rx<ScrollController> topRatedScrollController = ScrollController().obs;
  ScrollController homePageScrollController = ScrollController();
  Rx<ScrollController> comingPageScrollController = ScrollController().obs;
  ScrollController favPageScrollController = ScrollController();
  Rx<ScrollController> descPageScrollController = ScrollController().obs;
  //Rx<ScrollController> descScrollController = ScrollController();

  RxList<dynamic>? trendingNodes = [].obs;
  RxList<dynamic>? topRatedNodes = [].obs;
  RxList<dynamic>? tvShowsNodes = [].obs;
  RxList<dynamic>? posterNodes = [].obs;
  RxList<dynamic>? searchOptionsNodes = [].obs;
  RxList<dynamic>? sideNodes = [].obs;
  RxList<dynamic>? searchNodes = [].obs;
  RxList<dynamic>? comingNodes = [].obs;
  RxList<dynamic>? favNodes = [].obs;
  RxList<dynamic>? profileNodes = [].obs;
  RxList<dynamic>? descNodes = [].obs;
  // FocusNode testing = FocusNode();
  // testing.dispose()

  // List<FocusNode>? descNodes = [];
  RxList<dynamic>? videoPlayerNodes = [].obs;

  bool side = false;
  bool trend = false;
  bool top = false;
  bool tvShow = false;
  bool coming = false;
  bool fav = false;
  bool searchResult = false;
  bool searchField = false;
  bool profile = false;
  bool desc = false;
  bool videoP = false;

  int searchoptionIndex = 0;
  int posterIndex = 0;
  int descIndex = 0;
  int profileIndex = 0;
  int favIndex = 0;
  int searchIndex = 0;
  int navSelectedIndex = 0;
  int clickedIndex = 0;
  int trendingIndex = 0;
  int topIndex = 0;
  int tvIndex = 0;
  int comingIndex = 0;
  int videoIndex = 0;

  FocusNode? searchNode;
  FocusNode? moviDescNode;

  Color borderColor = Colors.black;
  void unFocus() {
    side = coming = fav = profile = top = trend = tvShow = false;
  }

  Map<Type, Action<Intent>> actionIntents(
      {BuildContext? context,
      Rx<ScrollController>? scrollController,
      int index = 1,
      RxList<dynamic>? nodes}) {
    print("scrollController is ${scrollController}");
    return <Type, Action<Intent>>{
      DownbuttonIntent: CallbackAction<DownbuttonIntent>(onInvoke: (intent) {
        // moveDown(context);
        scrollController!.value.animateTo(scrollController.value.offset + 150,
            duration: Duration(milliseconds: 800), curve: Curves.ease);
        scrollController.refresh();
      }),
      LeftbuttonIntent: CallbackAction<LeftbuttonIntent>(onInvoke: (intent) {
        print("index in left is $index");
        //moveLeft(context);
        // print("left " + _intentController.descIndex.toString());
        print("left " + index.toString());

        if (index > 0) {
          FocusScope.of(context!).requestFocus(nodes!.value[--index]);
          nodes.refresh();
        }
      }),
      RightbuttonIntent: CallbackAction<RightbuttonIntent>(onInvoke: (intent) {
        //moveRight(context);
        print("right");
        if (index < 1) {
          FocusScope.of(context!).requestFocus(nodes!.value[++index]);
          nodes.refresh();
        }
      }),
      UpbuttonIntent: CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
        scrollController!.value.animateTo(
          scrollController.value.offset - 150,
          duration: Duration(milliseconds: 800),
          curve: Curves.ease,
        );
        scrollController.refresh();
      })
    };
  }

  DownNavActions(BuildContext context) {
    //print("down");
    if (side == true && desc == false) {
      //// FocusScope.of(context).nextFocus();
      //// print("going to next focus ");
      //// print(FocusManager.instance.primaryFocus);
      //// print("This is the first node " + sideNodes![0].toString());
      // if (navSelectedIndex < 4) {
      //   print("inside teh change focus down ${navSelectedIndex}");
      //   FocusScope.of(context).requestFocus(sideNodes![navSelectedIndex + 1]);
      //   navSelectedIndex++;
      // }
    } else if (trend == true && desc == false) {
      topRatedScrollController.value.animateTo(0,
          duration: Duration(milliseconds: 800), curve: Curves.ease);
      FocusScope.of(context).requestFocus(topRatedNodes![0]);
      //print("top");
      homePageScrollController.animateTo(homePageScrollController.offset + 220,
          duration: Duration(milliseconds: 800), curve: Curves.ease);
      //trendingScrollController.jumpTo(5);
      trend = false;
      top = true;
      trendingIndex = 0;
    } else if (top == true && desc == false) {
      FocusScope.of(context).requestFocus(tvShowsNodes![0]);
      print("description");
      tvShowScrollController.value.animateTo(0,
          duration: Duration(milliseconds: 800), curve: Curves.ease);
      homePageScrollController.animateTo(homePageScrollController.offset + 250,
          duration: Duration(milliseconds: 800), curve: Curves.ease);
      top = false;
      tvShow = true;
      topIndex = 0;
    } else if (searchField == true && desc == false) {
      FocusScope.of(context).requestFocus(searchNodes![0]);
      searchField = false;
      searchResult = true;
    } else if (coming == true && desc == false) {
      if (comingIndex + 3 < comingNodes!.length) {
        FocusScope.of(context).requestFocus(comingNodes![comingIndex + 3]);
        comingIndex = comingIndex + 3;
        // comingPageScrollController.animateTo(
        //     comingPageScrollController.offset + 250,
        //     duration: Duration(milliseconds: 800),
        //     curve: Curves.ease);
      } else {
        FocusScope.of(context)
            .requestFocus(comingNodes![comingNodes!.length - 1]);
      }
    } else if (profile == true && desc == false) {
      print("inside profile ");
      if (profileIndex < profileNodes!.length - 1) {
        FocusScope.of(context).requestFocus(profileNodes![profileIndex + 1]);
        profileIndex++;
      }
    } else if (desc == true) {
      if (descIndex < descNodes!.length - 1) {
        FocusScope.of(context).requestFocus(descNodes![descIndex + 1]);
        descIndex++;
        // descPageScrollController.animateTo(
        //     descPageScrollController.offset + 150,
        //     duration: Duration(milliseconds: 800),
        //     curve: Curves.ease);
      } else
        print("I know hwy is is coming here ");
    }
  }

  UpNavActions(BuildContext context) {
    print("UP");
    if (side == true && desc == false) {
      FocusScope.of(context).previousFocus();
      print(FocusManager.instance.primaryFocus);
      // if (navSelectedIndex > -1) {
      //   print("inside teh change focus down ${navSelectedIndex}");
      //   FocusScope.of(context).requestFocus(sideNodes![navSelectedIndex - 1]);
      //   navSelectedIndex--;
      // }
    } else if (top == true && desc == false) {
      FocusScope.of(context).requestFocus(trendingNodes![0]);
      trendingScrollController.value.animateTo(0,
          duration: const Duration(milliseconds: 800), curve: Curves.ease);
      homePageScrollController.animateTo(homePageScrollController.offset - 220,
          duration: const Duration(milliseconds: 800), curve: Curves.ease);
      trend = true;
      top = false;
    } else if (tvShow == true && desc == false) {
      FocusScope.of(context).requestFocus(topRatedNodes![0]);
      topRatedScrollController.value.animateTo(0,
          duration: const Duration(milliseconds: 800), curve: Curves.ease);
      homePageScrollController.animateTo(homePageScrollController.offset - 220,
          duration: const Duration(milliseconds: 800), curve: Curves.ease);
      top = true;
      tvShow = false;
    } else if (coming == true && desc == false) {
      if (comingIndex - 3 > 0) {
        FocusScope.of(context).requestFocus(comingNodes![comingIndex - 3]);
        comingIndex = comingIndex - 3;
        // comingPageScrollController.animateTo(
        //     comingPageScrollController.offset - 200,
        //     duration: const Duration(milliseconds: 800),
        //     curve: Curves.ease);
      } else {
        FocusScope.of(context).requestFocus(comingNodes![0]);
        comingIndex = 0;
      }
    } else if (profile == true && desc == false) {
      if (profileIndex > 0) {
        FocusScope.of(context).requestFocus(profileNodes![profileIndex - 1]);
        profileIndex--;
        // favPageScrollController.animateTo(favPageScrollController.offset - 200,
        //     duration: Duration(microseconds: 50), curve: Curves.ease);
      }
    } else if (desc == true) {
      if (descIndex > 0) {
        FocusScope.of(context).requestFocus(descNodes![descIndex - 1]);
        descIndex--;
        // descPageScrollController.animateTo(
        //     descPageScrollController.offset - 150,
        //     duration: Duration(milliseconds: 800),
        //     curve: Curves.ease);
      } else
        print("I know hwy is is coming here ");
    }
  }

  RightNavActions(BuildContext context) {
    print("right");
    if (side == true && desc == false) {
      print("inside side true ");
      if (clickedIndex == 1) {
        print("inside clicked");
        FocusScope.of(context).requestFocus(searchNode);
        side = false;
        searchField = true;
        //trend = true;
      } else if (clickedIndex == 3) {
        FocusScope.of(context).requestFocus(comingNodes![0]);
        side = false;
        coming = true;
      } else if (clickedIndex == 4) {
        FocusScope.of(context).requestFocus(profileNodes![0]);
        print("i dont know how it is coming here ");
        side = false;
        profile = true;
      } else if (clickedIndex == 2) {
        FocusScope.of(context).requestFocus(comingNodes![0]);
        side = false;
        coming = true;

        // comingPageScrollController.animateTo(0,
        //     duration: Duration(seconds: 1), curve: Curves.ease);
      } else {
        FocusScope.of(context).requestFocus(trendingNodes![0]);
        trend = true;
        side = false;
      }
      navSelectedIndex = 0;
    } else if (trend == true && desc == false) {
      if (trendingIndex < _controller.trendingmovies.length - 1) {
        FocusScope.of(context).requestFocus(trendingNodes![trendingIndex + 1]);
        print("trening nodess");
        trendingScrollController.value.animateTo(
            trendingScrollController.value.offset + 230,
            curve: Curves.ease,
            duration: Duration(milliseconds: 800));
        trendingIndex++;
      }
    } else if (top == true && desc == false) {
      if (topIndex < _controller.topratedmovies.length - 1) {
        FocusScope.of(context).requestFocus(topRatedNodes![topIndex + 1]);
        topRatedScrollController.value.animateTo(
            topRatedScrollController.value.offset + 230,
            curve: Curves.ease,
            duration: Duration(milliseconds: 800));
        topIndex++;
      }
    } else if (tvShow == true && desc == false) {
      if (tvIndex < _controller.tv.length - 1) {
        tvShowScrollController.value.animateTo(
            tvShowScrollController.value.offset + 230,
            curve: Curves.ease,
            duration: Duration(milliseconds: 800));
        FocusScope.of(context).requestFocus(tvShowsNodes![tvIndex + 1]);
        tvIndex++;
      }
    } else if (coming == true && desc == false) {
      print("testing");
      if (comingIndex < _controller.trendingmovies.length - 1) {
        FocusScope.of(context).requestFocus(comingNodes![comingIndex + 1]);

        comingIndex++;
      }
    } else if (fav == true && desc == false) {
      if (favIndex < _controller.topratedmovies.length - 1) {
        FocusScope.of(context).requestFocus(favNodes![favIndex + 1]);

        favIndex++;
      }
    } else if (searchResult == true && desc == false) {
      if (searchIndex < _controller.localSearch.length - 1) {
        FocusScope.of(context).requestFocus(searchNodes![searchIndex + 1]);

        searchIndex++;
      }
    } else if (videoP == true && desc == false) {
      FocusScope.of(context).requestFocus(videoPlayerNodes![videoIndex]);
      print("here");
    }
    //print("out of range");
  }

  LeftNavActions(BuildContext context) {
    print("left");
    if (trend == true && desc == false) {
      if (trendingIndex <= 0) {
        FocusScope.of(context).requestFocus(sideNodes![0]);
        side = true;
        trend = false;
      } else {
        FocusScope.of(context).requestFocus(trendingNodes![trendingIndex - 1]);
        trendingScrollController.value.animateTo(
            trendingScrollController.value.offset - 230,
            curve: Curves.ease,
            duration: Duration(milliseconds: 800));
        trendingIndex--;
      }
    } else if (top == true && desc == false) {
      if (topIndex <= 0) {
        FocusScope.of(context).requestFocus(sideNodes![0]);
        side = true;
        top = false;
      } else {
        FocusScope.of(context).requestFocus(topRatedNodes![topIndex - 1]);
        // FocusScope.of(context).requestFocus(topRatedNodes![trendingIndex - 1]);
        topRatedScrollController.value.animateTo(
            trendingScrollController.value.offset - 230,
            curve: Curves.ease,
            duration: Duration(milliseconds: 800));
        topIndex--;
      }
    } else if (tvShow == true && desc == false) {
      if (tvIndex <= 0) {
        FocusScope.of(context).requestFocus(sideNodes![0]);
        side = true;
        tvShow = false;
      } else {
        FocusScope.of(context).requestFocus(tvShowsNodes![tvIndex - 1]);
        tvShowScrollController.value.animateTo(
            trendingScrollController.value.offset - 230,
            curve: Curves.ease,
            duration: Duration(milliseconds: 800));

        tvIndex--;
      }
    } else if (coming == true && desc == false) {
      if (comingIndex % 3 == 0) {
        FocusScope.of(context).requestFocus(sideNodes![0]);
        coming = false;
        side = true;
      } else {
        if (comingIndex > 0) {
          FocusScope.of(context).requestFocus(comingNodes![comingIndex - 1]);

          comingIndex--;
        }
      }
    } else if (searchResult == true && desc == false) {
      if (searchIndex > 0) {
        FocusScope.of(context).requestFocus(searchNodes![searchIndex - 1]);

        searchIndex--;
      } else {
        FocusScope.of(context).requestFocus(sideNodes![0]);
        side = true;
        searchResult = false;
        //FocusScope.of(context).requestFocus(searchNodes![searchIndex - 1]);
      }
    } else if (videoP == true && desc == false) {
      if (videoIndex > 0) {
        FocusScope.of(context).requestFocus(videoPlayerNodes![videoIndex - 1]);
        videoIndex--;
      }
    } else {
      FocusScope.of(context).requestFocus(sideNodes![0]);
      side = true;
      profile = false;
      profileIndex = 0;
    }
  }
}

SideBarNavigation(String direction) {}
ListNavigation(String direction, List list) {}
GridNavigation(
  String direction,
) {}
