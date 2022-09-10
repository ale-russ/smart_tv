// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_if_null_operators, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/view/movie_controller.dart';

import 'description.dart';

class TrendingMovies extends StatefulWidget {
  final List trending;

  const TrendingMovies({Key? key, required this.trending}) : super(key: key);

  @override
  State<TrendingMovies> createState() => _TrendingMoviesState();
}

class _TrendingMoviesState extends State<TrendingMovies> {
  Color textColor = Colors.white70;
  MoviesController controller = Get.find();
  // _setFirstFocus(BuildContext context) {
  //   if (controller.trendingNode == null) {
  //     controller.trendingNode = FocusNode();
  //     FocusScope.of(context).requestFocus(controller.trendingNode);
  //     setState(() {
  //       textColor = Colors.blue;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // if (controller.trendingNode == null) {
    //   _setFirstFocus(context);
    // }
    return Focus(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Modified_text(
              text: "Trending Movies",
              size: 26,
              color: textColor // Colors.white70,
              ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: widget.trending.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    for (var element in widget.trending) {
                      print(element);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => Description(
                              bannerurl:
                                  "https://image.tmdb.org/t/p/w500${widget.trending[index]['backdrop_path']}",
                              description: widget.trending[index]['overview'],
                              lauchOn: widget.trending[index]['release_date'],
                              name: widget.trending[index]['title'],
                              posterurl:
                                  "https://image.tmdb.org/t/p/w500${widget.trending[index]['backdrop_path']}",
                              vote: widget.trending[index]['vote_average']
                                  .toString(),
                            )),
                      ),
                    );
                  },
                  child: Container(
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
                                      "https://image.tmdb.org/t/p/w500${widget.trending[index]['poster_path']}",
                                    ),
                                    fit: BoxFit.cover))),
                        Container(
                          child: Modified_text(
                            text: widget.trending[index]['title'] ?? 'Loading',
                            color: Colors.white60,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
