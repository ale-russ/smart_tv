import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviesController extends GetxController {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  List allVideo = [];
  List searchresult = [];
  RxList localSearch = [].obs;
  FocusNode? trendingNode;
  FocusNode? topRatedNode;
  FocusNode? tvShowsNode;
  FocusNode? rightPage;
  Color borderColor = Colors.black;
}
