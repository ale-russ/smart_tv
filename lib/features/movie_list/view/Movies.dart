// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv/features/movie_list/controller/landing_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

import 'package:smart_tv/features/movie_list/widgets/toprated.dart';
import 'package:smart_tv/features/movie_list/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../widgets/trending.dart';
import 'movie_controller.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPage createState() => _MoviesPage();
}

class _MoviesPage extends State<MoviesPage> {
  final String apikey = 'f8242645e5c75f1aa66afeaeb47494e3';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODI0MjY0NWU1Yzc1ZjFhYTY2YWZlYWViNDc0OTRlMyIsInN1YiI6IjYzMTY0ZWU3YmExMzFiMDA4MWQxYWMwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0rthKmQIVTLgh9wFN7qkpMcmacpy1Juxib-KhJKXtEw';
  // List trendingmovies = [];
  // List topratedmovies = [];
  // List tv = [];
  // List allVideo = [];
  // List searchresult = [];
  MoviesController controller = Get.put(MoviesController());

  @override
  void initState() {
    super.initState();
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
    Map searchResult = await tmdbWithCustomLogs.v3.search
        .queryMovies("A", includeAdult: true, page: 3);
    Map allMovies = await tmdbWithCustomLogs.v3.discover
        .getMovies(sortBy: SortMoviesBy.orginalTitleAsc);
    //Map testing = await tmdbWithCustomLogs.v3.search.q
    Map tvresult = await tmdbWithCustomLogs.v3.search.queryMovies("hulk");
    //print(tv);
    setState(() {
      controller.trendingmovies = trendingresult['results'];
      controller.topratedmovies = topratedresult['results'];
      controller.tv = tvresult['results'];
      controller.searchresult = searchResult['results'];
      controller.allVideo = allMovies['results'];
      print(controller.searchresult);

      // controller.allVideo.addAll(tv);
      // controller.allVideo.addAll(controller.topratedmovies);
      // controller.allVideo.addAll(controller.trendingmovies);
      //print(controller.allVideo[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //
        title: const Modified_text(
          text: 'Smart-TV App ',
          size: 20,
          color: Colors.amber,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          TrendingMovies(
            trending: controller.trendingmovies,
          ),
          TopRated(
            toprated: controller.topratedmovies,
          ),
          TV(tv: controller.topratedmovies),
        ],
      ),
    );
  }
}
