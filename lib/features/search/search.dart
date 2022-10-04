import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/services/keys.dart';
import 'package:smart_tv/features/common/controller/tmdb_controller.dart';
import 'package:smart_tv/features/models/movies_model.dart';

import '../movie_list/utilits/text.dart';
import '../movie_list/controller/movie_controller.dart';
import '../movie_list/widgets/description.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key? key,
    required this.number,
  }) : super(key: key);
  final number;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // MoviesController Mcontroller = Get.find();
  final IntentController _intentController = Get.find();

  final TmdbController _tmdbController = Get.put(TmdbController());
  final CommonKeys _commonKeys = Get.find();

  List? searchResults;

  final MoviesController mController = Get.find();

  TextEditingController controller = TextEditingController();

  final int number = 0;

  @override
  void initState() {
    super.initState();
    _intentController.trend = false;

    _intentController.top = false;
    _intentController.tvShow = false;

    mController.loadmovies();
  }

  _SearchPageState();
  @override
  Widget build(BuildContext context) {
    // if (!_intentController.searchNode!.hasFocus) {
    //   FocusScope.of(context).requestFocus(_intentController.searchNode);
    //   setState(() {});
    // }
    if (_intentController.searchNodes!.isEmpty &&
        mController.localSearch.isNotEmpty) {
      for (var i = 0; i < mController.localSearch.length; i++) {
        _intentController.searchNodes!.add(FocusNode());
      }
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black38,
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.06,
                color: Colors.white,
                child: TextField(
                  focusNode: _intentController.searchNode,
                  controller: controller,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search...'),
                  onChanged: (search) async {
                    Map searchResult = await _tmdbController
                        .tmdbWithCustomLogs.v3.search
                        .queryMovies(search);

                    if (searchResult['results'] != null) {
                      print(searchResult['results']);

                      searchResults = searchResult['results'];
                      mController.localSearch.value = searchResults!;
                      if (mController.localSearch.isNotEmpty) {
                        for (var i = 0;
                            i < mController.localSearch.length;
                            i++) {
                          _intentController.searchNodes!.add(FocusNode());
                        }
                      }
                    }
                    if (controller.text == "") {
                      mController.localSearch.clear;
                      print("help");
                    }
                    setState(() {});
                  },
                  onEditingComplete: () {
                    print("on edite controller");
                    FocusScope.of(context)
                        .requestFocus(_intentController.searchNodes![index]);
                    _intentController.searchResult = true;
                    _intentController.searchField = false;
                    setState(() {});
                  },
                )),
          ),
          const Center(
            child: ModifiedText(
              text: "search result ",
              size: 16,
              color: Colors.white70,
            ),
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
              itemCount: mController.localSearch.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => Description(
                                bannerurl:
                                    "${_commonKeys.movieUrl}${mController.localSearch[index]['backdrop_path']}",
                                description: mController.localSearch[index]
                                    ['overview'],
                                lauchOn: mController.localSearch[index]
                                    ['release_date'],
                                name: mController.localSearch[index]['title'],
                                posterurl:
                                    "${_commonKeys.movieUrl}${mController.localSearch[index]['backdrop_path']}",
                                vote: mController.localSearch[index]
                                        ['vote_average']
                                    .toString(),
                              )),
                        ),
                      );
                    },
                    child: mController.localSearch.isNotEmpty
                        ? Focus(
                            focusNode: _intentController.searchNodes![index],
                            child: SizedBox(
                              width: 140,
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: _intentController
                                                  .searchNodes![index]
                                                  .hasFocus // Mcontroller
                                              ? Colors.amber
                                              : Colors.black),
                                      image: DecorationImage(
                                        image: mController.localSearch[index]
                                                    ['poster_path'] !=
                                                null
                                            ? NetworkImage(
                                                "${_commonKeys.movieUrl}${mController.localSearch[index]['poster_path']}")
                                            : const NetworkImage(
                                                "https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-7509.jpg"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: ModifiedText(
                                      text: mController.localSearch[index]
                                              ['title'] ??
                                          'Loading',
                                      color: Colors.white60,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar(
      {Key? key, required this.controller, required this.mController})
      : super(key: key);

  final TextEditingController controller;
  final MoviesController mController;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List? searchResults;

  final MoviesController mController = Get.find();
  final TmdbController _tmdbController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.06,
          color: Colors.white,
          //decoration: BoxDecoration(),
          child: TextField(
            autofocus: true,
            controller: widget.controller,
            decoration: const InputDecoration(
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...'),
            onChanged: (search) async {
              Map searchResult = await _tmdbController
                  .tmdbWithCustomLogs.v3.search
                  .queryMovies(search);

              if (searchResult['results'] != null) {
                print("clicked");
                searchResults = searchResult['results'];
                for (var item in searchResults!) {
                  if (!mController.localSearch.contains(item)) {
                    setState(() {
                      mController.localSearch.add(item);
                    });
                  }
                  // else if (mController.localSearch.contains(item)) {
                  //   mController.localSearch.remove(item);

                  //   }

                }
              }
            },
          )),
    );
  }
}
