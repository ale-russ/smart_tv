import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/services/keys.dart';
import 'package:smart_tv/features/common/controller/tmdb_controller.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/models/movies_model.dart';

import '../../config/intentFiles/button_intents.dart';
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
  final GlobalController _globalController = Get.find();

  // TextEditingController searchController = TextEditingController();

  final int number = 0;

  @override
  void initState() {
    super.initState();
    if (_intentController.searchOptionsNodes!.isEmpty) {
      for (var i = 0; i < 6; i++) {
        _intentController.searchOptionsNodes!.add(FocusNode());
      }
    }
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
      body: Obx(
        () => Container(
          color: Colors.black38,
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.08,
                  padding: EdgeInsets.only(top: 5, left: 5),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF).withOpacity(0.24),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: FocusableActionDetector(
                      shortcuts: _globalController.navigationIntents,
                      actions: <Type, Action<Intent>>{
                        DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                            onInvoke: (intent) {
                          FocusScope.of(context).requestFocus(
                              _intentController.searchOptionsNodes!.value[1]);
                        }),
                        ActivateIntent: CallbackAction<ActivateIntent>(
                            onInvoke: (intent) async {
                          await seachMovies(mController.searchController.text);
                          //print("search results ");
                          FocusScope.of(context).requestFocus(
                              _intentController.searchOptionsNodes!.value[0]);
                          // mController.searchController
                        })
                      },
                      child: TextField(
                        focusNode: _intentController.searchNode,
                        controller: mController.searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none, //Border(BorderSide.none),
                            contentPadding: EdgeInsets.all(2),
                            suffixIcon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.search)),
                            fillColor: Colors.white,
                            // prefixIcon: Icon(Icons.search),
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Colors.white)),
                        onChanged: (search) async {
                          await seachMovies(search);
                        },
                        onEditingComplete: () {
                          print("on edite controller");
                          FocusScope.of(context).requestFocus(
                              _intentController.searchNodes![index]);
                          // _intentController.searchResult = true;
                          // _intentController.searchField = false;
                          setState(() {});
                        },
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: const Center(
                child: ModifiedText(
                  text: "search by ",
                  size: 16,
                  color: Colors.white70,
                ),
              ),
            ),
            FocusableActionDetector(
              shortcuts: _globalController.navigationIntents,
              actions: <Type, Action<Intent>>{
                UpbuttonIntent:
                    CallbackAction<UpbuttonIntent>(onInvoke: (Intent) {
                  FocusScope.of(context)
                      .requestFocus(_intentController.searchNode);
                  _intentController.searchOptionsNodes!.refresh();
                }),
                LeftbuttonIntent:
                    CallbackAction<LeftbuttonIntent>(onInvoke: (intent) {
                  moveLeft(context);
                }),
                RightbuttonIntent:
                    CallbackAction<RightbuttonIntent>(onInvoke: (intent) {
                  moveRight(context);
                  // moveRight(context);
                }),
              },
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          searchOptionBox("Drama",
                              _intentController.searchOptionsNodes!.value[0]),
                          searchOptionBox("Action",
                              _intentController.searchOptionsNodes!.value[1]),
                          searchOptionBox("Documentary",
                              _intentController.searchOptionsNodes!.value[2]),
                          searchOptionBox("Short Movie",
                              _intentController.searchOptionsNodes!.value[3]),
                          //searchOptionBox("Long Short Movies"),
                          searchOptionBox("Tigriniya",
                              _intentController.searchOptionsNodes!.value[4]),
                          searchOptionBox("Feature Movies",
                              _intentController.searchOptionsNodes!.value[5]),
                          //searchOptionBox("Feature Movies")
                        ],
                      )
                    ],
                  )),
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
                          ? FocusableActionDetector(
                              //focusNode: _intentController.searchNodes![index],
                              actions: <Type, Action<Intent>>{
                                LeftbuttonIntent:
                                    CallbackAction<LeftbuttonIntent>(
                                        onInvoke: (intent) {
                                  if (_intentController.searchIndex <
                                      mController.localSearch.length - 1) {
                                    FocusScope.of(context).requestFocus(
                                        _intentController.searchNodes!.value[
                                            ++_intentController.searchIndex]);
                                    _intentController.searchNodes!.refresh();
                                  }
                                }),
                                RightbuttonIntent:
                                    CallbackAction<RightbuttonIntent>(
                                        onInvoke: (intent) {
                                  print("something ");
                                  if (_intentController.searchIndex <
                                      mController.localSearch.length - 1) {
                                    FocusScope.of(context).requestFocus(
                                        _intentController.searchNodes!.value[
                                            ++_intentController.searchIndex]);
                                    _intentController.searchNodes!.refresh();
                                  }
                                  // moveRight(context);

                                  //
                                  // moveRight(context);
                                }),
                              },
                              child: SearchCard(
                                  index: index,
                                  intentController: _intentController,
                                  mController: mController,
                                  commonKeys: _commonKeys),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              color: Colors.amber,
                            )),
                    ),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

  void moveLeft(BuildContext context) {
    if (_intentController.searchoptionIndex > 0) {
      FocusScope.of(context).requestFocus(_intentController
          .searchOptionsNodes!.value[--_intentController.searchoptionIndex]);
      _intentController.searchOptionsNodes!.refresh();
    } else {
      FocusScope.of(context).requestFocus(_intentController.sideNodes![0]);
      _intentController.searchOptionsNodes!.refresh();
    }
  }

  void moveRight(BuildContext context) {
    if (_intentController.searchoptionIndex < 6) {
      FocusScope.of(context).requestFocus(_intentController
          .searchOptionsNodes!.value[++_intentController.searchoptionIndex]);
      _intentController.searchOptionsNodes!.refresh();
    }
  }

  Focus searchOptionBox(String searchWord, FocusNode node) {
    return Focus(
      focusNode: node,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: node.hasFocus
                ? Border.all(color: PrimaryColorTones.mainColor)
                : Border.all(color: Color(0xFFFFFFFF).withOpacity(0.6))),
        child: Text(
          searchWord,
          style: TextStyle(
              fontSize: 16, color: Color(0xFFFFFFFF).withOpacity(0.6)),
        ),
      ),
    );
  }

  Future<void> seachMovies(String search) async {
    Map searchResult =
        await _tmdbController.tmdbWithCustomLogs.v3.search.queryMovies(search);

    if (searchResult['results'] != null) {
      print(searchResult['results']);

      searchResults = searchResult['results'];
      mController.localSearch.value = searchResults!;
      if (mController.localSearch.isNotEmpty) {
        for (var i = 0; i < mController.localSearch.length; i++) {
          _intentController.searchNodes!.add(FocusNode());
        }
      }
    }
    if (mController.searchController.text == "") {
      mController.localSearch.clear;
      print("help");
    }
    setState(() {});
  }
}

class SearchCard extends StatelessWidget {
  const SearchCard({
    Key? key,
    required IntentController intentController,
    required this.mController,
    required CommonKeys commonKeys,
    required this.index,
  })  : _intentController = intentController,
        _commonKeys = commonKeys,
        super(key: key);

  final IntentController _intentController;
  final MoviesController mController;
  final CommonKeys _commonKeys;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _intentController.searchNodes!.value[index],
      child: SizedBox(
        width: 140,
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                    color: _intentController
                            .searchNodes!.value[index].hasFocus // Mcontroller
                        ? Colors.amber
                        : Colors.black),
                image: DecorationImage(
                  image: mController.localSearch[index]['poster_path'] != null
                      ? NetworkImage(
                          "${_commonKeys.movieUrl}${mController.localSearch[index]['poster_path']}")
                      : const NetworkImage(
                          "https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-7509.jpg"),
                ),
              ),
            ),
            SizedBox(
              child: ModifiedText(
                text: mController.localSearch[index]['title'] ?? 'Loading',
                color: Colors.white60,
                size: 15,
              ),
            )
          ],
        ),
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
