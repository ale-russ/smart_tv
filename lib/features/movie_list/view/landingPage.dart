// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:smart_tv/features/movie_list/controller/landing_controller.dart';
import 'package:smart_tv/features/movie_list/model/movies_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/upcoming_movies/upcoming_movies.dart';

import '../../movie_detail/view/movie_detail.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<IconData> sideIcons = [
    Icons.search,
    Icons.favorite,
    Icons.home,
    Icons.movie
  ];

  List<Content>? movies;

  MovieController controller = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(child: Text("Open this")),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.15,
              child: Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: sideIcons.length,
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemBuilder: ((context, index) => IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return LandingPage();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          sideIcons[index],
                          color: Colors.amber,
                          size: 15,
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body:
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          // Container(
          //   decoration: BoxDecoration(
          //       border: Border.all(
          //     color: Colors.grey,
          //   )),
          //   width: MediaQuery.of(context).size.width * 0.15,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 90.0),
          //     child: ListView.separated(
          //       scrollDirection: Axis.vertical,
          //       itemCount: sideIcons.length,
          //       separatorBuilder: (context, index) => const SizedBox(),
          //       itemBuilder: ((context, index) => IconButton(
          //             onPressed: () {
          //               Navigator.pushReplacement(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (BuildContext context) {
          //                     return LandingPage();
          //                   },
          //                 ),
          //               );
          //             },
          //             icon: Icon(
          //               sideIcons[index],
          //               color: Colors.amber,
          //               size: 15,
          //             ),
          //           )),
          //     ),
          //   ),
          // ),
          Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Container(
              height: 20,
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Recommended",
                style: TextStyle(color: Colors.white),
              ),
            ),
            FutureBuilder<MoviesList>(
              future: controller.fetchMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const SizedBox.shrink();
                } else if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 18.0),
                    child: Text("Error"),
                  );
                } else if (snapshot.data?.movies!.isEmpty ?? true) {
                  return const SizedBox.shrink();
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 100,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.movies!.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 200,
                          child: snapshot.data!.movies![index].url.isNotEmpty
                              ? Image.network(snapshot.data!.movies![index].url)
                              : const Placeholder(
                                  color: Colors.yellow,
                                  fallbackHeight: 200,
                                ),
                        );
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      //   ],
      // )
    );
  }
}
