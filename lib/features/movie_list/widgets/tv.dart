// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

import 'description.dart';

class TV extends StatelessWidget {
  final List tv;

  const TV({Key? key, required this.tv}) : super(key: key);
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
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: tv.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Description(
                            bannerurl:
                                "https://image.tmdb.org/t/p/w500${tv[index]['backdrop_path']}",
                            description: tv[index]['overview'],
                            lauchOn: tv[index]['release_date'],
                            name: tv[index]['title'],
                            posterurl:
                                "https://image.tmdb.org/t/p/w500${tv[index]['backdrop_path']}",
                            vote: tv[index]['vote_average'].toString(),
                          )),
                    ),
                  );
                },
                child: tv[index]['title'] != null
                    ? Container(
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
                                      "https://image.tmdb.org/t/p/w500${tv[index]['poster_path']}",
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(
                              child: Modified_text(
                                text: tv[index]['title'] ?? 'Loading',
                                color: Colors.white60,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        )
      ]),
    );
  }
}
