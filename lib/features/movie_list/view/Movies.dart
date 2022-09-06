// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:smart_tv/features/models/movies_model.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

import 'package:smart_tv/features/movie_list/widgets/toprated.dart';
import 'package:smart_tv/features/movie_list/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../widgets/trending.dart';

class MoviesList extends StatefulWidget {
  @override
  _MoviesList createState() => _MoviesList();
}

class _MoviesList extends State<MoviesList> {
  final String apikey = 'f8242645e5c75f1aa66afeaeb47494e3';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODI0MjY0NWU1Yzc1ZjFhYTY2YWZlYWViNDc0OTRlMyIsInN1YiI6IjYzMTY0ZWU3YmExMzFiMDA4MWQxYWMwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0rthKmQIVTLgh9wFN7qkpMcmacpy1Juxib-KhJKXtEw';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

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
    print(tv);
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          //
          title: const Modified_text(
            text: 'Smart-TV App ',
            size: 20,
            color: Colors.amber,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.10,
              //color: Colors.red,
              child: Padding(
                  padding: const EdgeInsets.only(top: 90.0),
                  child: NavigationRail(
                      backgroundColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      onDestinationSelected: (value) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      destinations: [
                        const NavigationRailDestination(
                            icon: Icon(
                              Icons.home,
                              color: Colors.amber,
                            ),
                            label: Text('Home')),
                        const NavigationRailDestination(
                            icon: Icon(Icons.search, color: Colors.amber),
                            label: Text('search')),
                        const NavigationRailDestination(
                            icon: Icon(Icons.favorite, color: Colors.amber),
                            label: Text('Favorite')),
                        const NavigationRailDestination(
                            icon: Icon(Icons.movie, color: Colors.amber),
                            label: Text('Home')),
                      ],
                      selectedIndex: _selectedIndex)),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Container(
                        //  height: MediaQuery.of(context).size.height,
                        ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width * 0.80,
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ListView(
                              children: [
                                TrendingMovies(
                                  trending: trendingmovies,
                                ),
                                TopRated(
                                  toprated: topratedmovies,
                                ),
                                TV(tv: tv),
                                const SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}