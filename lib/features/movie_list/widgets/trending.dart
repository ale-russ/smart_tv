// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:smart_tv/features/movie_list/widgets/description.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;
  List<FocusNode>? nodes;

  TrendingMovies({Key? key, required this.trending}) : super(key: key);

  _setfistfocus(BuildContext context) {
    nodes ??= List.filled(trending.length, FocusNode());
    print(trending.length);
    FocusScope.of(context).requestFocus(nodes![0]);
    print("this is " + nodes![0].hasFocus.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (nodes == null) {
      _setfistfocus(context);
    }
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Modified_text(
          text: "Trending Movies",
          size: 26,
          color: Colors.white70,
        ),
        Container(
          height: 270,
          child: ListView.builder(
            itemCount: trending.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              print("this " + trending.length.toString());
              print(nodes![index].hasFocus);
              return InkWell(
                onTap: () => OnMovieTap(context, index),
                child: trending[index]['title'] != null
                    ? MovieCard(
                        node: nodes![index],
                        index: index,
                        trending: trending,
                        borderColor: !nodes![index].hasFocus
                            ? Colors.black
                            : Colors.blueAccent,
                      )
                    : Container(),
              );
            },
          ),
        )
      ]),
    );
  }

  OnMovieTap(BuildContext context, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => Description(
                bannerurl: 'https://image.tmdb.org/t/p/w500' +
                    trending[index]['backdrop_path'],
                description: trending[index]['overview'],
                launch_on: trending[index]['release_date'],
                name: trending[index]['title'],
                posterurl: 'https://image.tmdb.org/t/p/w500' +
                    trending[index]['backdrop_path'],
                vote: trending[index]['vote_average'].toString()))));
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
      padding: EdgeInsets.all(5),
      width: 250,
      child: Column(
        children: [
          Container(
              width: 250,
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage('https://image.tmdb.org/t/p/w500' +
                          trending[index]['poster_path']),
                      fit: BoxFit.cover))),
          Container(
            child: Modified_text(
              text: trending[index]['title'] != null
                  ? trending[index]['title']
                  : 'Loading',
              color: Colors.white60,
              size: 15,
            ),
          )
        ],
      ),
    );
  }
}
