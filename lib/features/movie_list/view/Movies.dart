// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv/features/movie_list/controller/landing_controller.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:smart_tv/features/models/movies_model.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/widgets/movies_tile.dart';

import 'package:smart_tv/features/movie_list/widgets/toprated.dart';
import 'package:smart_tv/features/movie_list/widgets/tv.dart';
import 'package:smart_tv/features/search/search.dart';
import 'package:tmdb_api/tmdb_api.dart';

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
  void setState(VoidCallback fn) {
    focusNodes = List.filled(controller.trendingmovies.length, FocusNode());
    super.setState(fn);
  }

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
    if (_sideBar == null) {
      _sideBar = FocusNode();
      _pageNode = FocusNode();
      FocusScope.of(context).requestFocus(_sideBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.loadmovies();

    if (_sideBar == null) {
      _setFirstFocus(context);
    }

    Timer(const Duration(seconds: 15), () {
      if (controller.trendingmovies.isNotEmpty) {
        data.value = true;
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        title: const ModifiedText(
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
            // TrendingMovies(trending: controller.trendingmovies),
            ComingSoon(
              movie: controller.trendingmovies,
            ),
            ComingSoon(
              movie: controller.tv,
            ),
            // TopRated(toprated: controller.topratedmovies),
            ProfilePage()
          ];
          return Row(
            children: [
              SizedBox(
                child: Focus(
                  focusNode: _sideBar,
                  child: NavRail(
                    selectedIndex: _selectedIndex,
                    sideNode: _sideBar!,
                    callback: (index) => setState(() {
                      _selectedIndex = index;
                    }),
                  ),
                ),
              ),
              const VerticalDivider(),
              Expanded(
                child: data.isFalse
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.amberAccent,
                      ))
                    : Focus(
                        focusNode: controller.rightPage,
                        child: pages[_selectedIndex]),
              ),
            ],
          );
        }),
      ),
    );
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

  _setFirstFocus(BuildContext context) {
    if (controller.trendingNode == null) {
      controller.trendingNode = FocusNode();
      FocusScope.of(context).requestFocus(controller.trendingNode);
      setState(() {
        textColor = Colors.blue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.trendingNode == null) {
      _setFirstFocus(context);
      print("side clicked should work please ");
    }
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      shrinkWrap: true,
      children: [
        TrendingMovies(
          //nodeLength: focusNode.length,
          trending: widget.trendingmovies,
        ),
        TopRated(
          toprated: widget.topratedmovies,
        ),
        TV(
          tv: widget.tv,
        ),
      ],
    );
  }
}
