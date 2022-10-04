import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/services/keys.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/widgets/description.dart';

class MoviesTile extends StatefulWidget {
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
          text: widget.title,
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
                child: Obx(
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
                            text: widget.movie![index]['title'] ?? 'Loading',
                            color: Colors.white,
                            size: 13,
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
      ],
    );
  }
}

// 