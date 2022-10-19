// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/services/keys.dart';

import 'package:tmdb_api/tmdb_api.dart';

import '../service/movie_service.dart';

class MoviesController extends GetxController {
  final CommonKeys _commonKeys = Get.put(CommonKeys());
  final GlobalController _globalController = Get.put(GlobalController());
  //final IntentController _intentController = Get.find(); //Get.find();
  TextEditingController searchController = TextEditingController();
  RxList trendingmovies = [].obs;
  List topratedmovies = [].obs;
  RxInt clickedIndex = 0.obs;
  List tv = [].obs;
  List allVideo = [].obs;
  List searchresult = [].obs;
  RxList localSearch = [].obs;
  RxInt currentPage = 0.obs;
  RxList<dynamic> descNodes = [].obs;
  RxList<dynamic>? trendingNodes = [].obs;
  RxList<dynamic>? topRatedNodes = [].obs;
  RxList<dynamic>? tvShowsNodes = [].obs;
  RxList<dynamic>? posterNodes = [].obs;
  RxList<dynamic>? sideNodes = [].obs;
  RxList<dynamic>? comingNodes = [].obs;
  RxList<dynamic>? favNodes = [].obs;
  RxList<dynamic>? profileNodes = [].obs;
  var isDataLoading = false.obs;

  String serverMessage = "";
  @override
  void onInit() async {
    print("controler nit");

    await loadmovies().then((value) {
      // if (sideNodes!.isEmpty) {
      //   initializeFocusNodes();
      // }
    });
    print(trendingmovies.length);
    // initializeFocusNodes();]
    super.onInit;
  }

  Future loadmovies() async {
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

      trendingmovies.value = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    } on Exception catch (err) {
      // TODO
      serverMessage = err.toString();
      log("Server Message is $serverMessage");
      print("Server message is $serverMessage");
    }
  }

  Future initializeFocusNodes() async {
    if (sideNodes!.isEmpty) {
      if (comingNodes!.isEmpty) {
        for (var i = 0; i < trendingmovies.length; i++) {
          var temp = FocusNode();
          comingNodes!.add(temp);

          print("hereeeee");
        }
        for (var i = 0; i < topratedmovies.length; i++) {
          var temp = FocusNode();
          favNodes!.add(temp);
          print("hereeeee");
        }
        // }
      }
      for (var i = 0; i < 5; i++) {
        sideNodes!.add(FocusNode(debugLabel: "side node $i"));
        print(sideNodes!.value[i]);
      }
      for (var i = 0; i < 3; i++) {
        posterNodes!.add(
          FocusNode(
            debugLabel: "poster $i",
          ),
        );
        printInfo(info: "video Node is $i");
      }
      for (var i = 0; i < 3; i++) {
        posterNodes!.add(
          FocusNode(
            debugLabel: "poster $i",
          ),
        );
        printInfo(info: "video Node is $i");
      }

      for (var i = 0; i < trendingmovies.length; i++) {
        trendingNodes!.add(FocusNode(debugLabel: "trending node $i"));
        comingNodes!.add(FocusNode(debugLabel: "coming node $i"));
        print("herh");
      }
      for (var i = 0; i < topratedmovies.length; i++) {
        var temp = FocusNode();
        topRatedNodes!.add(FocusNode(debugLabel: "top node $i"));
      }
      for (var i = 0; i < tv.length; i++) {
        var temp = FocusNode();
        tvShowsNodes!.add(FocusNode(debugLabel: "Tv node $i"));
      }
      for (var i = 0; i < 5; i++) {
        descNodes.add(FocusNode(debugLabel: "Tv node $i"));
      }
    }
    print("the length hereh  " + trendingmovies.length.toString());
    print("reloading initialise ");
    _globalController.initialised.value = true;

    Color borderColor = Colors.black;
  }

  TMDB fetchMovies() {
    TMDB tmdbWithCustomLogs = TMDB(
      // ApiKeys(apikey, readaccesstoken),
      ApiKeys(_commonKeys.apikey!, _commonKeys.readaccesstoken!),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    return tmdbWithCustomLogs;
  }
}
