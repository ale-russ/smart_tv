import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/widgets/description.dart';

// final String controller.movieUrl = "https://image.tmdb.org/t/p/w500";

class MoviesTile extends StatelessWidget {
  MoviesTile({
    Key? key,
    required this.title,
    this.movie,
    required this.nodes,
    required this.borderColor,
    required this.scrollController,
  }) : super(key: key);

  final String title;
  final List? movie;
  final List? nodes;
  final Color borderColor;
  final ScrollController scrollController;

  Color textColor = Colors.white;

  MoviesController controller = Get.put(MoviesController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ModifiedText(
          text: title,
          size: 18,
          color: textColor,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            controller: scrollController,
            itemCount: movie!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(controller.descNodes![0]);
                  controller.desc = true;
                  controller.unFocus();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Description(
                            bannerurl:
                                "${controller.movieUrl}${movie![index]['backdrop_path']}",
                            description: movie![index]['overview'],
                            lauchOn: movie![index]['release_date'],
                            name: movie![index]['title'],
                            posterurl:
                                "${controller.movieUrl}${movie![index]['backdrop_path']}",
                            vote: movie![index]['vote_average'].toString(),
                          )),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Focus(
                        focusNode: nodes![index],
                        child: Container(
                          width: 250,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: nodes![index].hasFocus
                                ? Border.all(color: Colors.amber)
                                : Border.all(color: borderColor),
                            image: DecorationImage(
                              image: NetworkImage(
                                "${controller.movieUrl}${movie![index]['poster_path']}",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: ModifiedText(
                          text: movie![index]['title'] ?? 'Loading',
                          color: Colors.white,
                          size: 13,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class ComingSoon extends StatefulWidget {
  ComingSoon({Key? key, this.movie}) : super(key: key);
  final List? movie;

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  MoviesController controller = Get.find();
  @override
  void initState() {
    if (controller.comingNodes!.isEmpty) {
      for (var i = 0; i < controller.trendingmovies.length; i++) {
        var temp = FocusNode();
        controller.comingNodes!.add(temp);
      }
    }
    super.initState();
  }

  int? count;

  MoviesController mController = Get.put(MoviesController());

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 650) {
      count = 2;
    } else if (MediaQuery.of(context).size.width > 1100) {
      count = 4;
    } else {
      count = 3;
    }
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: GridView.builder(
          controller: controller.comingPageScrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count!,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: widget.movie!.length,
          itemBuilder: (context, index) {
            return SizedBox(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Description(
                            bannerurl:
                                "${mController.movieUrl}${widget.movie![index]['backdrop_path']}",
                            description: widget.movie![index]['overview'],
                            lauchOn: widget.movie![index]['release_date'],
                            name: widget.movie![index]['title'],
                            posterurl:
                                "${mController.movieUrl}${widget.movie![index]['backdrop_path']}",
                            vote:
                                widget.movie![index]['vote_average'].toString(),
                          )),
                    ),
                  );
                },
                child: Focus(
                  focusNode: controller.comingNodes![index],
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: controller.comingNodes![index].hasFocus
                                ? Border.all(color: Colors.amber)
                                : Border.all(
                                    color: Colors.grey.withOpacity(0.3)),
                            image: DecorationImage(
                              image: NetworkImage(
                                "${mController.movieUrl}${widget.movie![index]['poster_path']}",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: ModifiedText(
                            text: widget.movie![index]['title'] ?? 'Loading',
                            color: Colors.white,
                            size: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
