// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

import 'description.dart';

class TV extends StatefulWidget {
  final List tv;

  const TV({Key? key, required this.tv}) : super(key: key);

  @override
  State<TV> createState() => _TVState();
}

class _TVState extends State<TV> {
  MoviesController controller = Get.find();

  @override
  void initState() {
    if (controller.tvShowsNodes!.isEmpty) {
      for (var i = 0; i < controller.tv.length; i++) {
        var temp = FocusNode();
        controller.tvShowsNodes!.add(temp);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Modified_text(
          text: "Tv Shows",
          size: 26,
          color: Colors.white70,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: widget.tv.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Description(
                            bannerurl:
                                "https://image.tmdb.org/t/p/w500${widget.tv[index]['backdrop_path']}",
                            description: widget.tv[index]['overview'],
                            lauchOn: widget.tv[index]['release_date'],
                            name: widget.tv[index]['title'],
                            posterurl:
                                "https://image.tmdb.org/t/p/w500${widget.tv[index]['backdrop_path']}",
                            vote: widget.tv[index]['vote_average'].toString(),
                          )),
                    ),
                  );
                },
                child: widget.tv[index]['title'] != null
                    ? Focus(
                        focusNode: controller.tvShowsNodes![0],
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
                                              .tvShowsNodes![index].hasFocus
                                          ? Colors.blue
                                          : Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w500${widget.tv[index]['poster_path']}",
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                child: Modified_text(
                                  text: widget.tv[index]['title'] ?? 'Loading',
                                  color: Colors.white60,
                                  size: 15,
                                ),
                              )
                            ],
                          ),
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
