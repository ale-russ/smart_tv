// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv/features/common/theme/themes.dart';

import 'package:smart_tv/features/movie_list/controller/landing_controller.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:smart_tv/features/models/movies_model.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/widgets/Movie_card.dart';
import 'package:smart_tv/features/movie_list/widgets/library.dart';
import 'package:smart_tv/features/movie_list/widgets/movies_tile.dart';

import 'package:smart_tv/features/movie_list/widgets/toprated.dart';
import 'package:smart_tv/features/movie_list/widgets/tv.dart';
import 'package:smart_tv/features/search/search.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../../config/intentFiles/button_intents.dart';

import '../../common/controller/intent_controllers.dart';
import '../../profile/screen/profile_page.dart';
import '../../search/searchPage.dart';
import '../widgets/sideBar.dart';
import '../widgets/trending.dart';
import '../controller/movie_controller.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPage createState() => _MoviesPage();
}

class _MoviesPage extends State<MoviesPage> {
  List<FocusNode>? rightFocusNodes;
  FocusNode? firstFocus = FocusNode();
  MoviesController controller = Get.put(MoviesController());
  final IntentController _controller = Get.put(IntentController());

  bool hasData = false;
  RxBool data = false.obs;

  List<Widget> pages = [];

  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = 0;
  // final selectedColor = Colors.white;
  // final unselectedColor = Colors.white60;
  // final labelStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  _setFirstFocus(BuildContext context) {
    if (_controller.sideNodes!.isEmpty) {
      for (var i = 0; i < 5; i++) {
        _controller.descNodes!.add(FocusNode(debugLabel: "desc node ${i}"));
        //  print("side node ${_controller.descNodes![i]}");
      }
      for (var i = 0; i < 3; i++) {
        _controller.posterNodes!.add(FocusNode(debugLabel: "poster $i"));
      }
      for (var i = 0; i < 5; i++) {
        //var temp = FocusNode();
        _controller.sideNodes!.add(FocusNode(debugLabel: "side node $i"));
      }
      for (var i = 0; i < controller.trendingmovies.length; i++) {
        _controller.trendingNodes!
            .add(FocusNode(debugLabel: "trending node $i"));
        _controller.comingNodes!.add(FocusNode(debugLabel: "coming node $i"));
        print("herh");
      }
      for (var i = 0; i < controller.topratedmovies.length; i++) {
        var temp = FocusNode();
        _controller.topRatedNodes!.add(FocusNode(debugLabel: "top node $i"));
      }
      for (var i = 0; i < controller.tv.length; i++) {
        var temp = FocusNode();
        _controller.tvShowsNodes!.add(FocusNode(debugLabel: "Tv node $i"));
      }
      _controller.searchNode = FocusNode();
      FocusScope.of(context).requestFocus(_controller.sideNodes![0]);
      _controller.side = true;
      print("help me ");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.loadmovies();

    if (_controller.sideNodes!.isEmpty) {
      _setFirstFocus(context);
    }

    Timer(const Duration(seconds: 10), () {
      print("timer");
      if (controller.trendingmovies.isNotEmpty) {
        data.value = true;
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        List<Widget> pages = [
          Movies(
            trendingmovies: controller.trendingmovies,
            topratedmovies: controller.topratedmovies,
            tv: controller.tv,
            focusNode: firstFocus,
          ),
          ComingSoon(
            movie: controller.trendingmovies,
          ),
          SearchPage(number: 0),
          // ComingSoon(
          //   movie: controller.tv,
          // ),
          Library(),
          ProfilePage(),
        ];
        return Row(
          children: [
            Container(
              // color: DarkModeColors.backgroundVariant,
              child: Center(
                child: SideBar(
                  selectedIndex: _selectedIndex,
                  callback: (index) => setState(() {
                    print("index is $index");

                    _controller.clickedIndex = _selectedIndex = index;
                  }),
                ),
              ),
              height: double.infinity,
            ),
            const VerticalDivider(),
            Expanded(
              child: data.isFalse
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.amber,
                    ))
                  : pages[_selectedIndex],
            ),
          ],
        );
      }),
    );
  }
}

typedef void setIndexCallback(int index);

class Movies extends StatefulWidget {
  Movies({
    Key? key,
    required this.trendingmovies,
    required this.topratedmovies,
    required this.tv,
    this.focusNode,
  }) : super(key: key);

  final List trendingmovies;
  final List topratedmovies;
  final List tv;
  final FocusNode? focusNode;

  final IntentController _controller = Get.find();

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  MoviesController controller = Get.find();
  Color textColor = Colors.white70;
  Color borderColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: ListView(
        controller: widget._controller.homePageScrollController,
        children: [
          Movie_card(),
          TrendingMovies(
            trending: widget.trendingmovies,
          ),
          TopRated(
            toprated: widget.topratedmovies,
          ),
          TV(tv: widget.tv),
        ],
      ),
    );
  }
}
