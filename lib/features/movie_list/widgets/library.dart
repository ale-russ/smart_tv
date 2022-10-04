import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/services/keys.dart';
import 'package:smart_tv/features/common/theme/text_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/widgets/description.dart';
import 'package:smart_tv/features/movie_list/widgets/movies_tile.dart';

class Library extends StatelessWidget {
  Library({super.key});

  MoviesController _moviesController = Get.put(MoviesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkModeColors.backgroundColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            LibraryTile(
              movies: _moviesController.trendingmovies,
              label: "History",
            ),
            SizedBox(
              height: 40,
            ),
            LibraryTile(
              movies: _moviesController.trendingmovies,
              label: "Watch Later",
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryTile extends StatelessWidget {
  LibraryTile({
    Key? key,
    required this.movies,
    required this.label,
  }) : super(key: key);

  CommonKeys _movieUrl = Get.put(CommonKeys());
  List? movies;
  String? label;

  @override
  Widget build(BuildContext context) {
    print("Movies are ${movies!.length}");

    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: KabbeeText.subtitle1(
                  label!,
                  customStyle: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: TextButton(
                  child: KabbeeText.subtitle1(
                    "See All",
                    customStyle: TextStyle(color: PrimaryColorTones.mainColor),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ComingSoon(
                    //       movie: movies,
                    //     ),
                    //   ),
                    // );
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            // width: 100,
            height: 140,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // itemCount: movies!.length,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Description(
                                  bannerurl:
                                      "${_movieUrl.movieUrl}${movies![index]['backdrop_path']}",
                                  description:
                                      "${_movieUrl.movieUrl}${movies![index]['overview']}",
                                  lauchOn:
                                      "${_movieUrl.movieUrl}${movies![index]['release_date']}",
                                  name:
                                      "${_movieUrl.movieUrl}${movies![index]['title']}",
                                  posterurl:
                                      "${_movieUrl.movieUrl}${movies![index]['backdrop_path']}",
                                  vote:
                                      "${_movieUrl.movieUrl}${movies![index]['vote_average'].toString()}"))));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 250,
                      height: 140,
                      decoration: BoxDecoration(
                          border: Border.all(color: DarkModeColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              "${_movieUrl.movieUrl}${movies![index]['backdrop_path']}",
                            ),
                          )),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
