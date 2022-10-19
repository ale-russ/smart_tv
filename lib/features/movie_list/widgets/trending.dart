// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_if_null_operators, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/widgets/movies_tile.dart';
import 'package:smart_tv/features/movie_list/widgets/toprated.dart';

import '../../../config/intentFiles/button_intents.dart';
import '../../common/controller/intent_controllers.dart';
import 'description.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  TrendingMovies({
    Key? key,
    required this.trending,
    //this.focusNode,
  }) : super(key: key);

  //FocusNode? focusNode = FocusNode();

  Color textColor = Colors.white70;

  MoviesController _controller = Get.find();

  IntentController _intentController = Get.find();

  GlobalController _globalController = Get.find();

  // @override
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      shortcuts: _globalController.navigationIntents,
      actions: <Type, Action<Intent>>{
        DownbuttonIntent: CallbackAction<DownbuttonIntent>(onInvoke: (intent) {
          moveDown(context);
        }),
        LeftbuttonIntent: CallbackAction<LeftbuttonIntent>(onInvoke: (intent) {
          moveLeft(context);
        }),
        RightbuttonIntent:
            CallbackAction<RightbuttonIntent>(onInvoke: (intent) {
          moveRight(context);
        }),
        UpbuttonIntent: CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
          moveUp(context);
        })
      },
      child: MoviesTile(
        title: "Trending Movies".tr,
        movie: trending,
        nodes: _controller.trendingNodes!,
        borderColor: Colors.grey.withOpacity(0.3),
        scrollController: _intentController.trendingScrollController.value,
      ),
    );
  }

  void moveUp(BuildContext context) {
    FocusScope.of(context).requestFocus(_controller.posterNodes![0]);
    _intentController.posterIndex = 0;
    _controller.trendingNodes!.refresh();
    _controller.posterNodes!.refresh();
  }

  void moveLeft(BuildContext context) {
    if (_intentController.trendingIndex <= 0) {
      FocusScope.of(context).requestFocus(_controller.sideNodes![0]);
    } else {
      FocusScope.of(context).requestFocus(
          _controller.trendingNodes![_intentController.trendingIndex - 1]);
      _intentController.trendingNodes!.refresh();
      _intentController.trendingScrollController.value.animateTo(
          _intentController.trendingScrollController.value.offset - 230,
          curve: Curves.ease,
          duration: Duration(milliseconds: 800));
      _intentController.trendingIndex--;
    }
    _controller.trendingNodes!.refresh();
    _controller.sideNodes!.refresh();
  }

  void moveRight(BuildContext context) {
    if (_intentController.trendingIndex <
        _controller.trendingmovies.length - 1) {
      FocusScope.of(context).requestFocus(
          _controller.trendingNodes![++_intentController.trendingIndex]);

      _intentController.trendingScrollController.value.animateTo(
          _intentController.trendingScrollController.value.offset + 230,
          curve: Curves.ease,
          duration: Duration(milliseconds: 800));
    }
    _controller.trendingNodes!.refresh();
  }

  void moveDown(BuildContext context) {
    _intentController.topRatedScrollController.value.animateTo(0,
        duration: Duration(milliseconds: 800), curve: Curves.ease);
    FocusScope.of(context).requestFocus(_controller.topRatedNodes![0]);
    _intentController.homePageScrollController.animateTo(
        _intentController.homePageScrollController.offset + 220,
        duration: Duration(milliseconds: 800),
        curve: Curves.ease);
    _intentController.trendingIndex = 0;
    _controller.trendingNodes!.refresh();
    _controller.topRatedNodes!.refresh();
  }
}
