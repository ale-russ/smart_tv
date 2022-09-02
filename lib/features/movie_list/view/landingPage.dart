// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:smart_tv/features/movie_list/model/movies_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../movie_detail/view/movie_detail.dart';

// class LandingPage extends StatefulWidget {
//   LandingPage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _LandingPageState createState() => _LandingPageState();
// }

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  List<IconData> sideIcons = [
    Icons.search,
    Icons.favorite,
    Icons.home,
    Icons.movie
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              //color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: ListView.separated(
                  itemCount: sideIcons.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      sideIcons[index],
                      color: Colors.white,
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 50,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recommended",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.80,
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: movieList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                    onTap: () => Get.to(() => MovieDetail(
                                          movieTitle: movieList[index].title,
                                          movieUrl: movieList[index].imgUrl,
                                        )),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          decoration: BoxDecoration(
                                              //color: Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.red,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    movieList[index].imgUrl,
                                                  ),
                                                  fit: BoxFit.cover)),
                                        )
                                      ],
                                    ),
                                  ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                        width: 10,
                                      )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
