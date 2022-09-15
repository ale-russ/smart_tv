import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_api/tmdb_api.dart';

const String apikey = '57320767d83adfa9f6adbe7d9582c9a2';
const String readaccesstoken =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NzMyMDc2N2Q4M2FkZmE5ZjZhZGJlN2Q5NTgyYzlhMiIsInN1YiI6IjYzMTcyZWRiYTg0YTQ3MDA4ZWEyZDQ2YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LEUuMeDszPWfsJdUynN-mX_tHu2dhdXEd05CdJS0qYA';

class MoviesController extends GetxController {
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

    print("tv is ${trendingmovies.length}");
  }

  ScrollController trendingScrollController = new ScrollController();
  ScrollController tvShowScrollController = new ScrollController();
  ScrollController topRatedScrollController = new ScrollController();
  ScrollController homePageScrollController = new ScrollController();

  List<FocusNode>? trendingNodes = [];
  List<FocusNode>? topRatedNodes = [];
  List<FocusNode>? tvShowsNodes = [];
  List<FocusNode>? sideNodes = [];
  List<FocusNode>? searchNodes = [];
  bool side = false;
  bool trend = false;
  bool top = false;
  bool tvShow = false;
  bool searchResult = false;
  bool searchField = false;
  int navSelectedIndex = 0;
  int trendingIndex = 0;
  int topIndex = 0;
  int tvIndex = 0;
  FocusNode? searchNode;
  // FocusNode? rightPage;
  // List<FocusNode>? rightPages;
  // FocusNode? topRatedNode;
  // FocusNode? trendingNode;
  // FocusNode? tvShowNode;
  // FocusNode? sideNode;
  Color homeColor = Colors.white;
  Color searchColor = Colors.white;
  Color upComingColor = Colors.white;
  Color profileColor = Colors.white;
  //FocusNode? trendingNode;
  Color borderColor = Colors.black;
  DownNavActions(BuildContext context) {
    if (side == true) {
      if (navSelectedIndex < 4) {
        print("inside teh change focus down ${navSelectedIndex}");
        FocusScope.of(context).requestFocus(sideNodes![navSelectedIndex + 1]);
        navSelectedIndex++;
      }
    } else if (trend == true) {
      FocusScope.of(context).requestFocus(topRatedNodes![0]);
      print("top");
      homePageScrollController.animateTo(homePageScrollController.offset + 180,
          duration: Duration(seconds: 1), curve: Curves.ease);
      //trendingScrollController.jumpTo(5);
      trend = false;
      top = true;
      trendingIndex = 0;
    } else if (top == true) {
      FocusScope.of(context).requestFocus(tvShowsNodes![0]);
      print("top");
      homePageScrollController.animateTo(homePageScrollController.offset + 180,
          duration: Duration(seconds: 1), curve: Curves.ease);
      top = false;
      tvShow = true;
      topIndex = 0;
    } else if (searchField == true) {
      FocusScope.of(context).requestFocus(searchNodes![0]);
      searchField = false;
      searchResult = true;
    }
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
      homePageScrollController.animateTo(homePageScrollController.offset - 180,
          duration: Duration(seconds: 1), curve: Curves.ease);
      trend = true;
      top = false;
    } else if (tvShow == true) {
      FocusScope.of(context).requestFocus(topRatedNodes![0]);
      homePageScrollController.animateTo(homePageScrollController.offset - 180,
          duration: Duration(seconds: 1), curve: Curves.ease);
      top = true;
      tvShow = false;
    }
  }

  RightNavActions(BuildContext context) {
    if (side == true) {
      if (navSelectedIndex == 1) {
        FocusScope.of(context).requestFocus(searchNode);
        side = false;
        searchField = true;
        //trend = true;
      } else if (navSelectedIndex == 3) {
        FocusScope.of(context).requestFocus(topRatedNodes![0]);
        side = false;
        top = true;
      } else if (navSelectedIndex == 4) {
        print("in the profile node");
      } else {
        FocusScope.of(context).requestFocus(trendingNodes![0]);
        side = false;
        trend = true;
      }
      navSelectedIndex = 0;
    } else if (trend == true) {
      if (trendingIndex < trendingmovies.length - 1) {
        FocusScope.of(context).requestFocus(trendingNodes![trendingIndex + 1]);
        trendingScrollController.animateTo(
            trendingScrollController.offset + 230,
            curve: Curves.ease,
            duration: Duration(seconds: 1));
        trendingIndex++;
      }
    } else if (top == true) {
      if (topIndex < topratedmovies.length - 1) {
        FocusScope.of(context).requestFocus(topRatedNodes![topIndex + 1]);
        topIndex++;
      }
    } else if (tvShow == true) {
      if (tvIndex < tv.length - 1) {
        print(tv.length);
        print(tvShow);
        FocusScope.of(context).requestFocus(tvShowsNodes![tvIndex + 1]);
        tvIndex++;
      }
    }
    print("out of range");
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
            duration: Duration(seconds: 1));
        trendingIndex--;
      }
    } else if (top == true) {
      if (topIndex <= 0) {
        FocusScope.of(context).requestFocus(sideNodes![0]);
        side = true;
        top = false;
      } else {
        FocusScope.of(context).requestFocus(topRatedNodes![topIndex - 1]);
        FocusScope.of(context).requestFocus(topRatedNodes![trendingIndex - 1]);
        topRatedScrollController.animateTo(
            trendingScrollController.offset - 230,
            curve: Curves.ease,
            duration: Duration(seconds: 1));
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
            curve: Curves.ease, duration: Duration(seconds: 1));

        tvIndex--;
      }
    } else {
      FocusScope.of(context).requestFocus(sideNodes![0]);
      side = true;
      searchNode!.unfocus();
    }
  }
}
