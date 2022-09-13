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

  FocusNode? trendingNode;
  FocusNode? topRatedNode;
  FocusNode? tvShowsNode;
  FocusNode? rightPage;
  //FocusNode? trendingNode;
  Color borderColor = Colors.black;
}
