// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

import '../../../config/intentFiles/button_intents.dart';
import 'description.dart';
import 'package:smart_tv/features/movie_list/widgets/movies_tile.dart';

class TV extends StatefulWidget {
  final List tv;

  const TV({Key? key, required this.tv}) : super(key: key);

  @override
  State<TV> createState() => _TVState();
}

class _TVState extends State<TV> {
  MoviesController controller = Get.find();
  final IntentController _intentController = Get.find();
  final GlobalController _globalController = Get.find();
  final MoviesController _moviesController = Get.find();

  @override
  void initState() {
    if (_intentController.tvShowsNodes!.isEmpty) {
      for (var i = 0; i < controller.tv.length; i++) {
        var temp = FocusNode();
        _intentController.tvShowsNodes!.add(temp);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      shortcuts: _globalController.navigationIntents,
      actions: <Type, Action<Intent>>{
        UpbuttonIntent: CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
          moveUp(context);
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
        movie: widget.tv,
        title: "Tv Shows".tr,
        nodes: _intentController.tvShowsNodes!,
        borderColor: Colors.grey.withOpacity(0.3),
        scrollController: _intentController.tvShowScrollController.value,
      ),
    );
  }

  void moveUp(BuildContext context) {
    FocusScope.of(context).requestFocus(_intentController.topRatedNodes![0]);
    _intentController.topRatedScrollController.value.animateTo(0,
        duration: const Duration(milliseconds: 800), curve: Curves.ease);
    _intentController.homePageScrollController.animateTo(
        _intentController.homePageScrollController.offset - 220,
        duration: const Duration(milliseconds: 800),
        curve: Curves.ease);
    _intentController.tvShowsNodes!.refresh();
    _intentController.topRatedNodes!.refresh();
  }

  void moveLeft(BuildContext context) {
    if (_intentController.tvIndex <= 0) {
      FocusScope.of(context).requestFocus(_intentController.sideNodes![0]);
    } else {
      FocusScope.of(context).requestFocus(
          _intentController.tvShowsNodes![_intentController.topIndex - 1]);
      // FocusScope.of(context).requestFocus(topRatedNodes![trendingIndex - 1]);
      _intentController.topRatedScrollController.value.animateTo(
          _intentController.trendingScrollController.value.offset - 230,
          curve: Curves.ease,
          duration: Duration(milliseconds: 800));
      _intentController.tvIndex--;
      _intentController.tvShowsNodes!.refresh();
    }
  }

  void moveRight(BuildContext context) {
    if (_intentController.tvIndex < _moviesController.tv.length - 1) {
      FocusScope.of(context).requestFocus(
          _intentController.tvShowsNodes![_intentController.tvIndex + 1]);
      _intentController.tvShowScrollController.value.animateTo(
          _intentController.tvShowScrollController.value.offset + 230,
          curve: Curves.ease,
          duration: Duration(milliseconds: 800));
      _intentController.tvIndex++;
      _intentController.tvShowsNodes!.refresh();
    }
  }
}
