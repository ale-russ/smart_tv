import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../movie_list/controller/movie_controller.dart';

class IntentController extends GetxController {
  MoviesController _controller = Get.find();

  ScrollController trendingScrollController = ScrollController();
  ScrollController tvShowScrollController = ScrollController();
  ScrollController topRatedScrollController = ScrollController();
  ScrollController homePageScrollController = ScrollController();
  ScrollController comingPageScrollController = ScrollController();
  ScrollController favPageScrollController = ScrollController();
  ScrollController descPageScrollController = ScrollController();

  List<FocusNode>? trendingNodes = [];
  List<FocusNode>? topRatedNodes = [];
  List<FocusNode>? tvShowsNodes = [];
  List<FocusNode>? sideNodes = [];
  List<FocusNode>? searchNodes = [];
  List<FocusNode>? comingNodes = [];
  List<FocusNode>? favNodes = [];
  List<FocusNode>? profileNodes = [];
  List<FocusNode>? descNodes = [];
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
  int descIndex = 0;
  int profileIndex = 0;
  int favIndex = 0;
  int navSelectedIndex = 0;
  int clickedIndex = 0;
  int trendingIndex = 0;
  int topIndex = 0;
  int tvIndex = 0;
  int comingIndex = 0;
  FocusNode? searchNode;

  Color borderColor = Colors.black;
  void unFocus() {
    side = coming = fav = profile = top = trend = tvShow = false;
  }

  DownNavActions(BuildContext context) {
    if (side == true) {
      if (navSelectedIndex < 4) {
        print("inside teh change focus down ${navSelectedIndex}");
        FocusScope.of(context).requestFocus(sideNodes![navSelectedIndex + 1]);
        navSelectedIndex++;
      }
    } else if (trend == true) {
      topRatedScrollController.animateTo(0,
          duration: Duration(milliseconds: 800), curve: Curves.ease);
      FocusScope.of(context).requestFocus(topRatedNodes![0]);
      //print("top");
      homePageScrollController.animateTo(homePageScrollController.offset + 180,
          duration: Duration(milliseconds: 800), curve: Curves.ease);
      //trendingScrollController.jumpTo(5);
      trend = false;
      top = true;
      trendingIndex = 0;
    } else if (top == true) {
      FocusScope.of(context).requestFocus(tvShowsNodes![0]);
      tvShowScrollController.animateTo(0,
          duration: Duration(microseconds: 50), curve: Curves.ease);
      homePageScrollController.animateTo(homePageScrollController.offset + 180,
          duration: Duration(microseconds: 50), curve: Curves.ease);
      top = false;
      tvShow = true;
      topIndex = 0;
    } else if (searchField == true) {
      FocusScope.of(context).requestFocus(searchNodes![0]);
      searchField = false;
      searchResult = true;
    } else if (coming == true) {
      if (comingIndex + 3 < comingNodes!.length) {
        FocusScope.of(context).requestFocus(comingNodes![comingIndex + 3]);
        comingIndex = comingIndex + 3;
        comingPageScrollController.animateTo(
            comingPageScrollController.offset + 200,
            duration: Duration(microseconds: 50),
            curve: Curves.ease);
      } else {
        FocusScope.of(context)
            .requestFocus(comingNodes![comingNodes!.length - 1]);
      }
    } else if (profile == true) {
      print("inside profile ");
      if (profileIndex < profileNodes!.length - 1) {
        FocusScope.of(context).requestFocus(profileNodes![profileIndex + 1]);
        profileIndex++;
      }
    } else if (desc == true) {
      if (descIndex < descNodes!.length - 1) {
        FocusScope.of(context).requestFocus(descNodes![descIndex + 1]);
        descIndex++;
        descPageScrollController.animateTo(
            descPageScrollController.offset + 150,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease);
      } else
        print("I know hwy is is coming here ");
    }
    print("down");
  }

  UpNavActions(BuildContext context) {
    if (side == true) {
      if (navSelectedIndex > -1) {
        print("inside teh change focus down ${navSelectedIndex}");
        FocusScope.of(context).requestFocus(sideNodes![navSelectedIndex - 1]);
        navSelectedIndex--;
      }
    } else if (top == true) {
      FocusScope.of(context).requestFocus(trendingNodes![0]);
      trendingScrollController.animateTo(0,
          duration: const Duration(microseconds: 50), curve: Curves.ease);
      homePageScrollController.animateTo(homePageScrollController.offset - 180,
          duration: const Duration(microseconds: 50), curve: Curves.ease);
      trend = true;
      top = false;
    } else if (tvShow == true) {
      FocusScope.of(context).requestFocus(topRatedNodes![0]);
      topRatedScrollController.animateTo(0,
          duration: const Duration(microseconds: 50), curve: Curves.ease);
      homePageScrollController.animateTo(homePageScrollController.offset - 180,
          duration: const Duration(microseconds: 50), curve: Curves.ease);
      top = true;
      tvShow = false;
    } else if (coming == true) {
      if (comingIndex - 3 > 0) {
        FocusScope.of(context).requestFocus(comingNodes![comingIndex - 3]);
        comingIndex = comingIndex - 3;
        comingPageScrollController.animateTo(
            comingPageScrollController.offset - 200,
            duration: const Duration(microseconds: 50),
            curve: Curves.ease);
      } else {
        FocusScope.of(context).requestFocus(comingNodes![0]);
        comingIndex = 0;
      }
    } else if (profile == true) {
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
        descPageScrollController.animateTo(
            descPageScrollController.offset - 150,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease);
      } else
        print("I know hwy is is coming here ");
    }
  }

  RightNavActions(BuildContext context) {
    if (side == true) {
      if (clickedIndex == 1) {
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
    } else if (trend == true) {
      if (trendingIndex < _controller.trendingmovies.length - 1) {
        FocusScope.of(context).requestFocus(trendingNodes![trendingIndex + 1]);
        print("trening nodess");
        trendingScrollController.animateTo(
            trendingScrollController.offset + 230,
            curve: Curves.ease,
            duration: Duration(microseconds: 100));
        trendingIndex++;
      }
    } else if (top == true) {
      if (topIndex < _controller.topratedmovies.length - 1) {
        FocusScope.of(context).requestFocus(topRatedNodes![topIndex + 1]);
        topRatedScrollController.animateTo(
            topRatedScrollController.offset + 230,
            curve: Curves.ease,
            duration: Duration(microseconds: 50));
        topIndex++;
      }
    } else if (tvShow == true) {
      if (tvIndex < _controller.tv.length - 1) {
        tvShowScrollController.animateTo(tvShowScrollController.offset + 230,
            curve: Curves.ease, duration: Duration(microseconds: 50));
        FocusScope.of(context).requestFocus(tvShowsNodes![tvIndex + 1]);
        tvIndex++;
      }
    } else if (coming == true) {
      print("testing");
      if (comingIndex < _controller.trendingmovies.length - 1) {
        FocusScope.of(context).requestFocus(comingNodes![comingIndex + 1]);

        comingIndex++;
      }
    } else if (fav == true) {
      if (favIndex < _controller.topratedmovies.length - 1) {
        FocusScope.of(context).requestFocus(favNodes![favIndex + 1]);

        favIndex++;
      }
    }
    //print("out of range");
  }

  LeftNavActions(BuildContext context) {
    if (trend == true) {
      if (trendingIndex <= 0) {
        FocusScope.of(context).requestFocus(sideNodes![0]);
        side = true;
        trend = false;
      } else {
        FocusScope.of(context).requestFocus(trendingNodes![trendingIndex - 1]);
        trendingScrollController.animateTo(
            trendingScrollController.offset - 230,
            curve: Curves.ease,
            duration: Duration(microseconds: 50));
        trendingIndex--;
      }
    } else if (top == true) {
      if (topIndex <= 0) {
        FocusScope.of(context).requestFocus(sideNodes![0]);
        side = true;
        top = false;
      } else {
        FocusScope.of(context).requestFocus(topRatedNodes![topIndex - 1]);
        // FocusScope.of(context).requestFocus(topRatedNodes![trendingIndex - 1]);
        topRatedScrollController.animateTo(
            trendingScrollController.offset - 230,
            curve: Curves.ease,
            duration: Duration(microseconds: 50));
        topIndex--;
      }
    } else if (tvShow == true) {
      if (tvIndex <= 0) {
        FocusScope.of(context).requestFocus(sideNodes![0]);
        side = true;
        tvShow = false;
      } else {
        FocusScope.of(context).requestFocus(tvShowsNodes![tvIndex - 1]);
        tvShowScrollController.animateTo(trendingScrollController.offset - 230,
            curve: Curves.ease, duration: Duration(microseconds: 50));

        tvIndex--;
      }
    } else if (coming == true) {
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
    } else {
      FocusScope.of(context).requestFocus(sideNodes![0]);
      side = true;
      profile = false;
      profileIndex = 0;
    }
  }
}
