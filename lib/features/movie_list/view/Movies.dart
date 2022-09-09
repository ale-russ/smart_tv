// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv/features/movie_list/controller/landing_controller.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:smart_tv/features/models/movies_model.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

import 'package:smart_tv/features/movie_list/widgets/toprated.dart';
import 'package:smart_tv/features/movie_list/widgets/tv.dart';
import 'package:smart_tv/features/search/search.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../profile/screen/profile_page.dart';
import '../widgets/sideBar.dart';
import '../widgets/trending.dart';
import 'movie_controller.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPage createState() => _MoviesPage();
}

class _MoviesPage extends State<MoviesPage> {
  final String apikey = 'f8242645e5c75f1aa66afeaeb47494e3';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODI0MjY0NWU1Yzc1ZjFhYTY2YWZlYWViNDc0OTRlMyIsInN1YiI6IjYzMTY0ZWU3YmExMzFiMDA4MWQxYWMwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0rthKmQIVTLgh9wFN7qkpMcmacpy1Juxib-KhJKXtEw';

  List<FocusNode>? focusNodes;
  MoviesController controller = Get.put(MoviesController());

  bool hasData = false;

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
    Map searchResult = await tmdbWithCustomLogs.v3.search
        .queryMovies("A", includeAdult: true, page: 3);
    Map allMovies = await tmdbWithCustomLogs.v3.discover
        .getMovies(sortBy: SortMoviesBy.orginalTitleAsc);
    //Map testing = await tmdbWithCustomLogs.v3.search.q
    Map tvresult = await tmdbWithCustomLogs.v3.search.queryMovies("hulk");
    //print(tv);
    setState(() {
      controller.trendingmovies = trendingresult['results'];
      controller.topratedmovies = topratedresult['results'];
      controller.tv = tvresult['results'];
      controller.searchresult = searchResult['results'];
      controller.allVideo = allMovies['results'];
      if (controller.trendingmovies.isNotEmpty) {
        hasData = true;
      }
      print("controller.searchresult");
      focusNodes = List.filled(controller.trendingmovies.length, FocusNode());
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

  List<IconData> sideIcons = [
    Icons.home,
    Icons.movie,
    Icons.search,
    Icons.favorite,
  ];

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
    if (_sideBar == null) {
      _setFirstFocus(context);
    }
    List<Widget> _pages = [
      Movies(
          trendingmovies: controller.trendingmovies,
          topratedmovies: controller.topratedmovies,
          tv: controller.tv),
      SeatchPage(number: 0),
      TrendingMovies(trending: controller.trendingmovies),
      TopRated(toprated: controller.topratedmovies),
      ProfilePage()
    ];

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
      body: Row(
        children: [
          SizedBox(
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
            child: !hasData
                ? const Center(
                    child: Text(
                      "Page is loading...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : _pages[_selectedIndex],
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
          //nodeLength: focusNode.length,
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
