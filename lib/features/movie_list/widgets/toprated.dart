// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_if_null_operators, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';

import '../../../config/intentFiles/button_intents.dart';
import '../controller/movie_controller.dart';

import 'package:smart_tv/features/movie_list/widgets/movies_tile.dart';

class TopRated extends StatefulWidget {
  final List toprated;

  const TopRated({Key? key, required this.toprated}) : super(key: key);

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  MoviesController controller = Get.find();
  final IntentController _intentController = Get.find();
  final GlobalController _globalController = Get.find();
  final MoviesController _moviesController = Get.find();

  @override
  void initState() {
    if (_intentController.topRatedNodes!.isEmpty) {
      for (var i = 0; i < controller.topratedmovies.length; i++) {
        var temp = FocusNode();
        _intentController.topRatedNodes!.add(temp);
      }
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return FocusableActionDetector(
      shortcuts: _globalController.navigationIntents,
      actions: <Type, Action<Intent>>{
        UpbuttonIntent: CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
          moveUp(context);
        }),
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
      },
      child: MoviesTile(
        movie: widget.toprated,
        title: "Top Rated Movies",
        nodes: _moviesController.topRatedNodes!,
        borderColor: Colors.grey.withOpacity(0.3),
        scrollController: _intentController.topRatedScrollController.value,
      ),
    );
  }

  void moveUp(BuildContext context) {
    FocusScope.of(context).requestFocus(_intentController.trendingNodes![0]);
    _intentController.trendingScrollController.value.animateTo(0,
        duration: const Duration(milliseconds: 800), curve: Curves.ease);
    _intentController.homePageScrollController.animateTo(
        _intentController.homePageScrollController.offset - 220,
        duration: const Duration(milliseconds: 800),
        curve: Curves.ease);
    _intentController.trendingNodes!.refresh();
    _intentController.topRatedNodes!.refresh();
  }

  void moveLeft(BuildContext context) {
    if (_intentController.topIndex <= 0) {
      FocusScope.of(context).requestFocus(_intentController.sideNodes![0]);
    } else {
      FocusScope.of(context).requestFocus(
          _intentController.topRatedNodes![_intentController.topIndex - 1]);
      // FocusScope.of(context).requestFocus(topRatedNodes![trendingIndex - 1]);
      _intentController.topRatedScrollController.value.animateTo(
          _intentController.trendingScrollController.value.offset - 230,
          curve: Curves.ease,
          duration: Duration(milliseconds: 800));
      _intentController.topIndex--;
      _intentController.topRatedNodes!.refresh();
    }
  }

  void moveRight(BuildContext context) {
    if (_intentController.topIndex <
        _moviesController.topratedmovies.length - 1) {
      FocusScope.of(context).requestFocus(
          _intentController.topRatedNodes![_intentController.topIndex + 1]);
      _intentController.topRatedScrollController.value.animateTo(
          _intentController.topRatedScrollController.value.offset + 230,
          curve: Curves.ease,
          duration: Duration(milliseconds: 800));
      _intentController.topIndex++;
      _intentController.topRatedNodes!.refresh();
    }
  }

  void moveDown(BuildContext context) {
    FocusScope.of(context).requestFocus(_intentController.tvShowsNodes![0]);

    _intentController.tvShowScrollController.value.animateTo(0,
        duration: Duration(milliseconds: 800), curve: Curves.ease);
    _intentController.homePageScrollController.animateTo(
        _intentController.homePageScrollController.offset + 250,
        duration: Duration(milliseconds: 800),
        curve: Curves.ease);
    _intentController.topRatedNodes!.refresh();
    _intentController.tvShowsNodes!.refresh();
    _intentController.topIndex = 0;
  }
}
