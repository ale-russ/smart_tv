// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smart_tv/features/models/movies_model.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/view/favorites.dart';
import 'package:smart_tv/features/movie_list/view/movie_controller.dart';

import 'package:smart_tv/features/movie_list/widgets/toprated.dart';
import 'package:smart_tv/features/movie_list/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../profile/views/profile.dart';
import '../widgets/sideBar.dart';
import '../widgets/trending.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPage createState() => _MoviesPage();
}

class _MoviesPage extends State<MoviesPage> {
  final String apikey = 'f8242645e5c75f1aa66afeaeb47494e3';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODI0MjY0NWU1Yzc1ZjFhYTY2YWZlYWViNDc0OTRlMyIsInN1YiI6IjYzMTY0ZWU3YmExMzFiMDA4MWQxYWMwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0rthKmQIVTLgh9wFN7qkpMcmacpy1Juxib-KhJKXtEw';

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
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();
    setState(() {
      controller.trendingmovies = trendingresult['results'];
      controller.topratedmovies = topratedresult['results'];
      controller.tv = tvresult['results'];
    });
  }

  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = 0;
  final selectedColor = Colors.white;
  final unselectedColor = Colors.white60;
  final labelStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Movies(
          trendingmovies: controller.trendingmovies,
          topratedmovies: controller.topratedmovies,
          tv: controller.tv),
      TrendingMovies(trending: controller.trendingmovies),
      TopRated(toprated: controller.topratedmovies),
      const Favorites(),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Modified_text(
          text: 'Smart-TV App ',
          size: 20,
          color: Colors.amber,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Row(
        children: [
          Container(
            color: Colors.transparent,
            child: NavRail(
              selectedIndex: _selectedIndex,
              // groupAlignment: groupAlignment,
              callback: (index) => setState(() {
                _selectedIndex = index;
              }),
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

typedef void setIndexCallback(int index);

class Movies extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TrendingMovies(
          trending: trendingmovies,
        ),
        TopRated(
          toprated: topratedmovies,
        ),
        TV(tv: tv),
      ],
    );
  }
}
