import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/keys.dart';
import 'package:smart_tv/features/movie_list/widgets/description.dart';

import '../controller/movie_controller.dart';

class Movie_card extends StatelessWidget {
  Movie_card({Key? key}) : super(key: key);

  MoviesController controller = Get.find();

  CommonKeys movieUrl = Get.put(CommonKeys());

  Random random = Random();
  int index = 0;

  void getRandom() async {
    index = random.nextInt(controller.topratedmovies.length);
  }

  @override
  Widget build(BuildContext context) {
    getRandom();

    return InkWell(
      onTap: () {},
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        // child: Description(
        //   bannerurl:
        //       "${movieUrl.movieUrl}${controller.topratedmovies[index]['backdrop_path']}",
        //   description:
        //       "${movieUrl.movieUrl}${controller.topratedmovies[index]['overview']}",
        //   lauchOn:
        //       "${movieUrl.movieUrl}${controller.topratedmovies[index]['release_date']}",
        //   name:
        //       "${movieUrl.movieUrl}${controller.topratedmovies[index]['title']}",
        //   vote:
        //       "${movieUrl.movieUrl}${controller.topratedmovies[index]['vote_average']}",
        //   posterurl:
        //       "${movieUrl.movieUrl}${controller.topratedmovies[index]['backdrop_path']}",
        // ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          image: DecorationImage(
            image: NetworkImage(
              "${movieUrl.movieUrl}${controller.topratedmovies[index]['backdrop_path']}",
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
