// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_if_null_operators, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

import 'description.dart';

class TopRated extends StatelessWidget {
  final List toprated;

  const TopRated({Key? key, required this.toprated}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Modified_text(
          text: "Top Rated Movies",
          size: 26,
          color: Colors.white70,
        ),
        Container(
          height: 270,
          child: ListView.builder(
            itemCount: toprated.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  for (var element in toprated) {
                    print(element);
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => Description(
                              bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                  toprated[index]['backdrop_path'],
                              description: toprated[index]['overview'],
                              launch_on: toprated[index]['release_date'],
                              name: toprated[index]['title'],
                              posterurl: 'https://image.tmdb.org/t/p/w500' +
                                  toprated[index]['backdrop_path'],
                              vote: toprated[index]['vote_average']
                                  .toString()))));
                },
                child: Container(
                  width: 140,
                  child: Column(
                    children: [
                      Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          toprated[index]['poster_path'])))),
                      Container(
                        child: Modified_text(
                          text: toprated[index]['title'] != null
                              ? toprated[index]['title']
                              : 'Loading',
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
    );
  }
}
