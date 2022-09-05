// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:smart_tv/features/movie_list/view/landingPage.dart';

class Upcoming extends StatelessWidget {
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
                child: ListView(scrollDirection: Axis.vertical, children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LandingPage()));
                      },
                      icon: const Icon(
                        Icons.home,
                        color: Colors.amber,
                        size: 30,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.amber,
                        size: 30,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.amber,
                        size: 30,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
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
                        "Upcoming Movies",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2500)),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: const Image(
                                      image: NetworkImage(
                                          'https://i.pinimg.com/750x/81/05/68/8105682cc9ff27350245080b4b5b4f8f.jpg'),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Image(
                                    image: NetworkImage(
                                        'https://i.pinimg.com/474x/a5/b0/ce/a5b0ce37b85d1acb704901b4afe0d887.jpg'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.blueGrey,
                                      content: const Text(
                                        'not released',
                                      ),
                                      action: SnackBarAction(
                                        label: 'ok',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );
                                  },
                                  child: const Image(
                                    image: NetworkImage(
                                        'https://i.pinimg.com/474x/5b/c9/a6/5bc9a6a973acbfdf9d96c0268262a312.jpg'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Image(
                                    image: NetworkImage(
                                        'https://i.pinimg.com/564x/89/59/c4/8959c4e6248b7f5d8dd1f78af38a9b7f.jpg'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Image(
                                    image: NetworkImage(
                                        'https://i.pinimg.com/474x/90/40/f5/9040f5f7421ddd58d65b7b37191ec404.jpg'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Image(
                                    image: NetworkImage(
                                        'https://i.pinimg.com/474x/bd/ca/63/bdca633d2d36c0e824fb3cda0423dead.jpg'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
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
