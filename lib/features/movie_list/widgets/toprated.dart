// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_if_null_operators, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

import '../controller/movie_controller.dart';
import 'description.dart';

class TopRated extends StatefulWidget {
  final List toprated;

  const TopRated({Key? key, required this.toprated}) : super(key: key);

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  MoviesController controller = Get.find();
  @override
  @override
  void initState() {
    if (controller.topRatedNodes!.isEmpty) {
      for (var i = 0; i < controller.topratedmovies.length; i++) {
        var temp = FocusNode();
        controller.topRatedNodes!.add(temp);
      }
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Modified_text(
          text: "Top Rated Movies",
          size: 26,
          color: Colors.white70,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            controller: controller.topRatedScrollController,
            itemCount: widget.toprated.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  for (var element in widget.toprated) {
                    print(element);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Description(
                            bannerurl:
                                "https://image.tmdb.org/t/p/w500${widget.toprated[index]['backdrop_path']}",
                            description: widget.toprated[index]['overview'],
                            lauchOn: widget.toprated[index]['release_date'],
                            name: widget.toprated[index]['title'],
                            posterurl:
                                "https://image.tmdb.org/t/p/w500${widget.toprated[index]['backdrop_path']}",
                            vote: widget.toprated[index]['vote_average']
                                .toString(),
                          )),
                    ),
                  );
                },
                child: Focus(
                  focusNode: controller.topRatedNodes![index],
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: 250,
                    child: Column(
                      children: [
                        Container(
                            width: 250,
                            height: 140,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: controller
                                            .topRatedNodes![index].hasFocus
                                        ? Colors.amber
                                        : Colors.black),
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w500${widget.toprated[index]['poster_path']}",
                                    ),
                                    fit: BoxFit.cover))),
                        Container(
                          child: Modified_text(
                            text: widget.toprated[index]['title'] ?? 'Loading',
                            color: Colors.white60,
                            size: 15,
                          ),
                        )
                      ],
                    ),
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
