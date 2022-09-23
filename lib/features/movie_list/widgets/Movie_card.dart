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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => Description(
                bannerurl:
                    "${movieUrl.movieUrl}${controller.topratedmovies[index]['backdrop_path']}",
                description:
                    "${movieUrl.movieUrl}${controller.topratedmovies[index]['overview']}",
                lauchOn:
                    "${movieUrl.movieUrl}${controller.topratedmovies[index]['release_date']}",
                name:
                    "${movieUrl.movieUrl}${controller.topratedmovies[index]['title']}",
                posterurl:
                    "${movieUrl.movieUrl}${controller.topratedmovies[index]['backdrop_path']}",
                vote:
                    "${movieUrl.movieUrl}${controller.topratedmovies[index]['vote_average'.toString()]}")),
          ),
        );
      },
      child: Stack(
        children: [
          Positioned(
            child: Container(
              margin: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
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
          ),
          Positioned(
            left: 30,
            bottom: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffffa600),
                fixedSize: const Size(180, 40),
              ),
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.play_arrow_rounded,
                    size: 30,
                  ),
                  Text(
                    "Play",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 230,
            bottom: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  fixedSize: const Size(180, 40),
                  side: const BorderSide(color: Color(0xffffa600))),
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.play_arrow_rounded,
                    size: 30,
                  ),
                  Text(
                    "Watch Trailer",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
