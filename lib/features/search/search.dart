import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../movie_list/utilits/text.dart';
import '../movie_list/controller/movie_controller.dart';
import '../movie_list/widgets/description.dart';

class SeatchPage extends StatefulWidget {
  SeatchPage({
    Key? key,
    required this.number,
  }) : super(key: key);
  final number;
  @override
  State<SeatchPage> createState() => _SeatchPageState();
}

class _SeatchPageState extends State<SeatchPage> {
  List? searchResults;
  String? apikey = 'f8242645e5c75f1aa66afeaeb47494e3';
  String? readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODI0MjY0NWU1Yzc1ZjFhYTY2YWZlYWViNDc0OTRlMyIsInN1YiI6IjYzMTY0ZWU3YmExMzFiMDA4MWQxYWMwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0rthKmQIVTLgh9wFN7qkpMcmacpy1Juxib-KhJKXtEw';
  final MoviesController mController = Get.find();
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys('f8242645e5c75f1aa66afeaeb47494e3',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODI0MjY0NWU1Yzc1ZjFhYTY2YWZlYWViNDc0OTRlMyIsInN1YiI6IjYzMTY0ZWU3YmExMzFiMDA4MWQxYWMwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0rthKmQIVTLgh9wFN7qkpMcmacpy1Juxib-KhJKXtEw'),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );
  TextEditingController controller = TextEditingController();
  // MoviesController mController = Get.find();
  final int number = 0;
  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey!, readaccesstoken!),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
  }

  void initState() {
    super.initState();
    loadmovies();
  }

  _SeatchPageState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // SearchBar(
          //   controller: controller,
          //   mController: mController,
          // ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.06,
                color: Colors.white,
                // decoration: BoxDecoration(),
                child: TextField(
                  autofocus: true,
                  controller: controller,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search...'),
                  onChanged: (search) async {
                    Map searchResult =
                        await tmdbWithCustomLogs.v3.search.queryMovies(search);

                    if (searchResult['results'] != null) {
                      print(searchResult['results']);
                      List temp = [];
                      searchResults = searchResult['results'];
                      mController.localSearch.value = searchResults!;
                      print("object");
                      for (var item in searchResults!) {
                        if (!mController.localSearch.contains(item)) {
                          setState(() {
                            mController.localSearch.add(item);
                          });
                        } else if (mController.localSearch.contains(item)) {
                          mController.localSearch.remove(item);
                        }
                      }
                    }
                    if (controller.text == "") {
                      mController.localSearch.value.clear;
                      print("help");
                    }
                    setState(() {});
                  },
                )),
          ),
          const Center(
            child: Modified_text(
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
                                    "https://image.tmdb.org/t/p/w500${mController.localSearch[index]['backdrop_path']}",
                                description: mController.localSearch[index]
                                    ['overview'],
                                lauchOn: mController.localSearch[index]
                                    ['release_date'],
                                name: mController.localSearch[index]['title'],
                                posterurl:
                                    "https://image.tmdb.org/t/p/w500${mController.localSearch[index]['backdrop_path']}",
                                vote: mController.localSearch[index]
                                        ['vote_average']
                                    .toString(),
                              )),
                        ),
                      );
                    },
                    child: mController.localSearch.isNotEmpty
                        ? SizedBox(
                            width: 140,
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: mController.localSearch[index]
                                                  ['poster_path'] !=
                                              null
                                          ? NetworkImage(
                                              "https://image.tmdb.org/t/p/w500${mController.localSearch[index]['poster_path']}")
                                          : const NetworkImage(
                                              "https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-7509.jpg"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Modified_text(
                                    text: mController.localSearch[index]
                                            ['title'] ??
                                        'Loading',
                                    color: Colors.white60,
                                    size: 15,
                                  ),
                                )
                              ],
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
  State<SearchBar> createState() => _SearchBarState(this.mController);
}

class _SearchBarState extends State<SearchBar> {
  List? searchResults;
  String apikey = 'f8242645e5c75f1aa66afeaeb47494e3';
  String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODI0MjY0NWU1Yzc1ZjFhYTY2YWZlYWViNDc0OTRlMyIsInN1YiI6IjYzMTY0ZWU3YmExMzFiMDA4MWQxYWMwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0rthKmQIVTLgh9wFN7qkpMcmacpy1Juxib-KhJKXtEw';
  final MoviesController mController;
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys('f8242645e5c75f1aa66afeaeb47494e3',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODI0MjY0NWU1Yzc1ZjFhYTY2YWZlYWViNDc0OTRlMyIsInN1YiI6IjYzMTY0ZWU3YmExMzFiMDA4MWQxYWMwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0rthKmQIVTLgh9wFN7qkpMcmacpy1Juxib-KhJKXtEw'),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  _SearchBarState(this.mController);
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
              Map searchResult =
                  await tmdbWithCustomLogs.v3.search.queryMovies(search);

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
