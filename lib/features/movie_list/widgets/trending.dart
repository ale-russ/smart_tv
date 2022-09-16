// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_if_null_operators, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/widgets/movies_tile.dart';
import 'package:smart_tv/features/movie_list/widgets/toprated.dart';

import 'description.dart';

class TrendingMovies extends StatefulWidget {
  final List trending;
  List<FocusNode>? nodes;

  TrendingMovies({
    Key? key,
    required this.trending,
    this.focusNode,
  }) : super(key: key);

  FocusNode? focusNode = FocusNode();

  _setfirstfocus(BuildContext context) {
    nodes ??= List.filled(trending.length, FocusNode());
    print(trending.length);

    FocusScope.of(context).requestFocus(nodes![0]);
    print("this is " + nodes![0].hasFocus.toString());
  }

  @override
  State<TrendingMovies> createState() => _TrendingMoviesState();
}

class _TrendingMoviesState extends State<TrendingMovies> {
  Color textColor = Colors.white70;
  MoviesController controller = Get.find();

  @override
  void initState() {
    if (controller.trendingNodes!.isEmpty) {
      for (var i = 0; i < controller.trendingmovies.length; i++) {
        var temp = FocusNode();
        controller.trendingNodes!.add(temp);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Container(
        // padding: const EdgeInsets.all(0),
        child: MoviesTile(
          title: "Trending Movies",
          movie: widget.trending,
          nodes: controller.trendingNodes,
          borderColor: Colors.grey.withOpacity(0.3),
          scrollController: controller.trendingScrollController,
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.trending,
    required this.index,
    required this.borderColor,
    required this.node,
  }) : super(key: key);

  final List trending;
  final int index;
  final Color borderColor;
  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: borderColor // Colors.blueAccent,
              )),
      padding: const EdgeInsets.all(5),
      width: 250,
      child: Column(
        children: [
          Container(
              width: 250,
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                        "https://image.tmdb.org/t/p/w500${trending[index]['backdrop_path']}",
                      ),
                      fit: BoxFit.cover))),
          SizedBox(
            child: ModifiedText(
              text: trending[index]['title'] ?? 'Loading',
              color: Colors.white60,
              size: 15,
            ),
          )
        ],
      ),
    );
  }
}
