// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/services/keys.dart';

import 'package:tmdb_api/tmdb_api.dart';

import '../service/movie_service.dart';

class MoviesController extends GetxController {
  final CommonKeys _commonKeys = Get.put(CommonKeys());
  TextEditingController searchController = TextEditingController();
  List trendingmovies = [].obs;
  List topratedmovies = [].obs;
  List tv = [].obs;
  List allVideo = [].obs;
  List searchresult = [].obs;
  RxList localSearch = [].obs;
  RxInt currentPage = 0.obs;

  var isDataLoading = false.obs;

  String serverMessage = "";

  void initState() {
    super.onInit;
    loadmovies();
  }

  loadmovies() async {
    try {
      TMDB tmdbWithCustomLogs = MovieService().fetchMovies();

      Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
      Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
      Map tvresult = await tmdbWithCustomLogs.v3.search.queryMovies("hulk");
      // print('tv is $tvresult');

      // if (trendingresult.isEmpty ||
      //     topratedresult.isEmpty ||
      //     tvresult.isEmpty) {
      //   serverMessage = "Content not found";
      // }

      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    } on Exception catch (err) {
      // TODO
      serverMessage = err.toString();
      log("Server Message is $serverMessage");
      print("Server message is $serverMessage");
    }
  }
}
