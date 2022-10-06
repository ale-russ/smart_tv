import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/services/keys.dart';
import 'package:smart_tv/features/common/theme/text_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/widgets/description.dart';

class MoviesTile extends StatefulWidget {
  MoviesTile(
      {Key? key,
      required this.title,
      required this.movie,
      required this.nodes,
      required this.borderColor,
      required this.scrollController,
      this.onSearch = false})
      : super(key: key);

  final onSearch;
  final String? title;
  final List? movie;
  final RxList? nodes;
  final Color borderColor;
  final ScrollController scrollController;

  @override
  State<MoviesTile> createState() => _MoviesTileState();
}

class _MoviesTileState extends State<MoviesTile> {
  Color textColor = Colors.white;

  MoviesController controller = Get.put(MoviesController());

  final IntentController _intentController = Get.find();

  final CommonKeys _commonKeys = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ModifiedText(
          text: widget.title!,
          size: 18,
          color: textColor,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            controller: widget.scrollController,
            itemCount: widget.movie!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  FocusScope.of(context)
                      .requestFocus(_intentController.descNodes![0]);
                  _intentController.desc = true;
                  // _intentController.unFocus();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Description(
                            bannerurl:
                                "${_commonKeys.movieUrl}${widget.movie![index]['backdrop_path']}",
                            description: widget.movie![index]['overview'],
                            lauchOn: widget.movie![index]['release_date'] ?? "",
                            name: widget.movie![index]['title'] ?? "",
                            posterurl:
                                "${_commonKeys.movieUrl}${widget.movie![index]['backdrop_path']}",
                            vote:
                                widget.movie![index]['vote_average'].toString(),
                          )),
                    ),
                  );
                },
                child: widget.movie!.isNotEmpty
                    ? Obx(
                        () => Container(
                          padding: const EdgeInsets.only(right: 5),
                          width: 205,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Focus(
                                focusNode: widget.nodes![index],
                                child: Container(
                                  width: 200,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: widget.nodes!.value[index].hasFocus
                                        ? Border.all(color: Colors.amber)
                                        : Border.all(color: widget.borderColor),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "${_commonKeys.movieUrl}${widget.movie![index]['poster_path']}",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: ModifiedText(
                                  text: widget.movie![index]['title'] ??
                                      'Loading',
                                  color: Colors.white,
                                  size: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
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
  final IntentController _intentController = Get.find();
  final CommonKeys _commonKeys = Get.find();
  @override
  void initState() {
    if (_intentController.comingNodes!.isEmpty) {
      for (var i = 0; i < controller.trendingmovies.length; i++) {
        var temp = FocusNode();
        _intentController.comingNodes!.add(temp);
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
      backgroundColor: DarkModeColors.backgroundColor,
      appBar: GetPlatform.isDesktop
          ? AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      body: Container(
        decoration: BoxDecoration(
          color: DarkModeColors.backgroundColor,
        ),
        child: GridView.builder(
          controller: _intentController.comingPageScrollController.value,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count!,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: widget.movie!.length,
          itemBuilder: (context, index) {
            return Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Description(
                            bannerurl:
                                "${_commonKeys.movieUrl}${widget.movie![index]['backdrop_path']}",
                            description: widget.movie![index]['overview'] ?? "",
                            lauchOn: widget.movie![index]['release_date'] ?? "",
                            name: widget.movie![index]['title'] ?? "",
                            posterurl:
                                "${_commonKeys.movieUrl}${widget.movie![index]['backdrop_path']}",
                            vote:
                                widget.movie![index]['vote_average'].toString(),
                          )),
                    ),
                  );
                },
                child: Focus(
                  focusNode: _intentController.comingNodes![index],
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  _intentController.comingNodes![index].hasFocus
                                      ? Border.all(color: Colors.amber)
                                      : Border.all(
                                          color: Colors.grey.withOpacity(0.3)),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "${_commonKeys.movieUrl}${widget.movie![index]['poster_path']}",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: KabbeeText.headline6(
                            widget.movie![index]['title'] ?? "Loading",
                            customStyle:
                                TextStyle(color: Colors.white.withAlpha(255)),
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
