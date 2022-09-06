// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:smart_tv/features/movie_list/widgets/description.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  const TrendingMovies({Key? key, required this.trending}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              return InkWell(
                onTap: () {
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
                              vote: trending[index]['vote_average']
                                  .toString()))));
                },
                child: trending[index]['title'] != null
                    ? Container(
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                trending[index]
                                                    ['poster_path'])))),
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
                      )
                    : Container(),
              );
            },
          ),
        )
      ]),
    );
  }
}
