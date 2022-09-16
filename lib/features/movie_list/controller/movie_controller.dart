import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_api/tmdb_api.dart';

const String apikey = '57320767d83adfa9f6adbe7d9582c9a2';
const String readaccesstoken =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NzMyMDc2N2Q4M2FkZmE5ZjZhZGJlN2Q5NTgyYzlhMiIsInN1YiI6IjYzMTcyZWRiYTg0YTQ3MDA4ZWEyZDQ2YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LEUuMeDszPWfsJdUynN-mX_tHu2dhdXEd05CdJS0qYA';

class MoviesController extends GetxController {
  final String movieUrl = "https://image.tmdb.org/t/p/w500";

  List trendingmovies = [].obs;
  List topratedmovies = [].obs;
  List tv = [].obs;
  List allVideo = [].obs;
  List searchresult = [].obs;
  RxList localSearch = [].obs;

  var isDataLoading = false.obs;

  void initState() {
    super.onInit;
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.search.queryMovies("hulk");
    // print('tv is $tvresult');

    trendingmovies = trendingresult['results'];
    topratedmovies = topratedresult['results'];
    tv = tvresult['results'];

    //print("tv is ${trendingmovies.length}");
  }

  ScrollController trendingScrollController = new ScrollController();
  ScrollController tvShowScrollController = new ScrollController();
  ScrollController topRatedScrollController = new ScrollController();
  ScrollController homePageScrollController = new ScrollController();
  ScrollController comingPageScrollController = new ScrollController();
  ScrollController favPageScrollController = new ScrollController();
  ScrollController descPageScrollController = new ScrollController();

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
          duration: Duration(microseconds: 50), curve: Curves.ease);
      homePageScrollController.animateTo(homePageScrollController.offset - 180,
          duration: Duration(microseconds: 50), curve: Curves.ease);
      trend = true;
      top = false;
    } else if (tvShow == true) {
      FocusScope.of(context).requestFocus(topRatedNodes![0]);
      topRatedScrollController.animateTo(0,
          duration: Duration(microseconds: 50), curve: Curves.ease);
      homePageScrollController.animateTo(homePageScrollController.offset - 180,
          duration: Duration(microseconds: 50), curve: Curves.ease);
      top = true;
      tvShow = false;
    } else if (coming == true) {
      if (comingIndex - 3 > 0) {
        FocusScope.of(context).requestFocus(comingNodes![comingIndex - 3]);
        comingIndex = comingIndex - 3;
        comingPageScrollController.animateTo(
            comingPageScrollController.offset - 200,
            duration: Duration(microseconds: 50),
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
      if (trendingIndex < trendingmovies.length - 1) {
        FocusScope.of(context).requestFocus(trendingNodes![trendingIndex + 1]);
        print("trening nodess");
        trendingScrollController.animateTo(
            trendingScrollController.offset + 230,
            curve: Curves.ease,
            duration: Duration(microseconds: 100));
        trendingIndex++;
      }
    } else if (top == true) {
      if (topIndex < topratedmovies.length - 1) {
        FocusScope.of(context).requestFocus(topRatedNodes![topIndex + 1]);
        topRatedScrollController.animateTo(
            topRatedScrollController.offset + 230,
            curve: Curves.ease,
            duration: Duration(microseconds: 50));
        topIndex++;
      }
    } else if (tvShow == true) {
      if (tvIndex < tv.length - 1) {
        tvShowScrollController.animateTo(tvShowScrollController.offset + 230,
            curve: Curves.ease, duration: Duration(microseconds: 50));
        FocusScope.of(context).requestFocus(tvShowsNodes![tvIndex + 1]);
        tvIndex++;
      }
    } else if (coming == true) {
      print("testing");
      if (comingIndex < trendingmovies.length - 1) {
        FocusScope.of(context).requestFocus(comingNodes![comingIndex + 1]);

        comingIndex++;
      }
    } else if (fav == true) {
      if (favIndex < topratedmovies.length - 1) {
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
