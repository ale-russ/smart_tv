// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv/config/intentFiles/left_intent.dart';
import 'package:smart_tv/features/movie_list/controller/landing_controller.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:smart_tv/features/models/movies_model.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

import 'package:smart_tv/features/movie_list/widgets/toprated.dart';
import 'package:smart_tv/features/movie_list/widgets/tv.dart';
import 'package:smart_tv/features/search/search.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../../config/intentFiles/down_intent.dart';
import '../../../config/intentFiles/right_intent.dart';
import '../../../config/intentFiles/up_intent.dart';
import '../../profile/screen/profile_page.dart';
import '../widgets/sideBar.dart';
import '../widgets/trending.dart';
import '../controller/movie_controller.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPage createState() => _MoviesPage();
}

class _MoviesPage extends State<MoviesPage> {
  List<FocusNode>? focusNodes;
  MoviesController controller = Get.put(MoviesController());

  bool hasData = false;
  RxBool data = false.obs;

  List<Widget> pages = [];

  @override
  // void setState(VoidCallback fn) {
  //   focusNodes = List.filled(controller.trendingmovies.length, FocusNode());
  //   super.setState(fn);
  // }

  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = 0;
  final selectedColor = Colors.white;
  final unselectedColor = Colors.white60;
  final labelStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  FocusNode? _sideBar;
  FocusNode? _pageNode;
  _setFirstFocus(BuildContext context) {
    if (controller.sideNodes!.isEmpty) {
      // _sideBar = FocusNode();
      // _pageNode = FocusNode();
      //print("inside the setfirstfocus");
      for (var i = 0; i < 5; i++) {
        var temp = FocusNode();
        controller.sideNodes!.add(temp);
      }
      for (var i = 0; i < controller.trendingmovies.length; i++) {
        print("inside the setfirstfocusff ${controller.trendingmovies.length}");
        var temp = FocusNode();
        controller.trendingNodes!.add(temp);
      }
      for (var i = 0; i < controller.topratedmovies.length; i++) {
        var temp = FocusNode();
        controller.topRatedNodes!.add(temp);
      }
      for (var i = 0; i < controller.tv.length; i++) {
        var temp = FocusNode();
        controller.tvShowsNodes!.add(temp);
      }
      controller.searchNode = FocusNode();
      FocusScope.of(context).requestFocus(controller.sideNodes![0]);
      controller.side = true;

      setState(() {});
    }
  }

  _changeNodeFocus(BuildContext build, String direction) {
    if (direction == "Down") {
      controller.DownNavActions(context);
      setState(() {});
    } else if (direction == "Up") {
      controller.UpNavActions(context);
      setState(() {});
    } else if (direction == "Right") {
      controller.RightNavActions(context);
      setState(() {});
    } else if (direction == "Left") {
      controller.LeftNavActions(context);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.loadmovies();

    if (controller.sideNodes!.isEmpty) {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        title: const Modified_text(
          text: 'Smart-TV App ',
          size: 20,
          color: Colors.amber,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        (() {
          List<Widget> pages = [
            Movies(
                trendingmovies: controller.trendingmovies,
                topratedmovies: controller.topratedmovies,
                tv: controller.tv),
            SeatchPage(number: 0),
            TrendingMovies(trending: controller.trendingmovies),
            TopRated(toprated: controller.topratedmovies),
            ProfilePage()
          ];
          return Shortcuts(
            shortcuts: {
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
              LogicalKeySet(LogicalKeyboardKey.arrowRight): RightbuttonIntent(),
              LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftbuttonIntent(),
              LogicalKeySet(LogicalKeyboardKey.arrowUp): UpbuttonIntent(),
              LogicalKeySet(LogicalKeyboardKey.arrowDown): DownbuttonIntent(),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                    onInvoke: (Intent) => _changeNodeFocus(context, "Down")),
                UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                    onInvoke: (Intent) => _changeNodeFocus(context, "Up")),
                RightbuttonIntent: CallbackAction<RightbuttonIntent>(
                    onInvoke: (Intent) => _changeNodeFocus(context, "Right")),
                LeftbuttonIntent: CallbackAction<LeftbuttonIntent>(
                    onInvoke: (Intent) => _changeNodeFocus(context, "Left")),
              },
              child: Row(
                children: [
                  SizedBox(
                    child: NavRail(
                      selectedIndex: _selectedIndex,
                      //sideNode: controller.sideNode!,
                      callback: (index) => setState(() {
                        _selectedIndex = index;
                      }),
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: data.isFalse
                        ? const Center(child: CircularProgressIndicator())
                        : pages[_selectedIndex],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  DownNavActions() {
    if (controller.side == true) {
      if (controller.navSelectedIndex < 4) {
        print("inside teh change focus down ${controller.navSelectedIndex}");
        FocusScope.of(context).requestFocus(
            controller.sideNodes![controller.navSelectedIndex + 1]);
        controller.navSelectedIndex++;
      }
    } else if (controller.trend == true) {
      FocusScope.of(context).requestFocus(controller.topRatedNodes![0]);
      print("top");
      controller.trend = false;
      controller.top = true;
    } else if (controller.top == true) {
      FocusScope.of(context).requestFocus(controller.tvShowsNodes![0]);
      print("top");
      controller.top = false;
      controller.tvShow = true;
    }
    setState(() {});
  }
}

typedef void setIndexCallback(int index);

class Movies extends StatefulWidget {
  const Movies({
    Key? key,
    required this.trendingmovies,
    required this.topratedmovies,
    required this.tv,
  }) : super(key: key);

  final List trendingmovies;
  final List topratedmovies;
  final List tv;

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  MoviesController controller = Get.find();
  Color textColor = Colors.white70;
  Color borderColor = Colors.black;

  // _setFirstFocus(BuildContext context) {
  //   if (controller.sideNode == null) {
  //     controller.sideNode = FocusNode();
  //     FocusScope.of(context).requestFocus(controller.sideNode);
  //     setState(() {
  //       textColor = Colors.blue;
  //       // controller.homeColor = Colors.blue;
  //       // controller.searchColor =
  //       //     controller.upComingColor = controller.profileColor = Colors.white;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // if (controller.trendingNode == null) {
    //   _setFirstFocus(context);
    //   print("side clicked should work please ");
    // }
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: controller.borderColor)),
      child: ListView(
        controller: controller.homePageScrollController,
        children: [
          TrendingMovies(
            //nodeLength: focusNode.length,
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
