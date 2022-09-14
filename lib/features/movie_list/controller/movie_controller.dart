import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_api/tmdb_api.dart';

const String apikey = 'f8242645e5c75f1aa66afeaeb47494e3';
const String readaccesstoken =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODI0MjY0NWU1Yzc1ZjFhYTY2YWZlYWViNDc0OTRlMyIsInN1YiI6IjYzMTY0ZWU3YmExMzFiMDA4MWQxYWMwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0rthKmQIVTLgh9wFN7qkpMcmacpy1Juxib-KhJKXtEw';

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
    // Map searchResult = await tmdbWithCustomLogs.v3.search
    //     .queryMovies("A", includeAdult: true, page: 3);
    // Map allMovies = await tmdbWithCustomLogs.v3.discover
    //     .getMovies(sortBy: SortMoviesBy.orginalTitleAsc);
    Map tvresult = await tmdbWithCustomLogs.v3.search.queryMovies("hulk");
    // print('tv is $tvresult');

    trendingmovies = trendingresult['results'];
    topratedmovies = topratedresult['results'];
    tv = tvresult['results'];

    print("tv is ${trendingmovies.length}");
  }

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
      trend = false;
      top = true;
    } else if (top == true) {
      FocusScope.of(context).requestFocus(tvShowsNodes![0]);
      print("top");
      top = false;
      tvShow = true;
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
      trend = true;
      top = false;
    } else if (tvShow == true) {
      FocusScope.of(context).requestFocus(topRatedNodes![0]);
      top = true;
      tvShow = false;
    }
  }

  RightNavActions(BuildContext context) {
    if (side == true) {
      FocusScope.of(context).requestFocus(trendingNodes![0]);
      side = false;
      trend = true;
    } else if (trend == true) {
      if (trendingIndex < trendingmovies.length - 1) {
        FocusScope.of(context).requestFocus(trendingNodes![trendingIndex + 1]);
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
        trendingIndex--;
      }
    } else if (top == true) {
      if (topIndex <= 0) {
        FocusScope.of(context).requestFocus(sideNodes![0]);
        side = true;
        top = false;
      } else {
        FocusScope.of(context).requestFocus(topRatedNodes![topIndex - 1]);
        topIndex--;
      }
    } else if (tvShow == true) {
      if (trendingIndex <= 0) {
        FocusScope.of(context).requestFocus(sideNodes![0]);
        side = true;
        tvShow = false;
      } else {
        FocusScope.of(context).requestFocus(tvShowsNodes![tvIndex - 1]);
        tvIndex--;
      }
    } else {
      FocusScope.of(context).requestFocus(sideNodes![0]);
      side = true;
      searchNode!.unfocus();
    }
  }
}
