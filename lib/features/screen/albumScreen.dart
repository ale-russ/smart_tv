import 'package:flutter/material.dart';
//import 'package:mezmur/screen/homeScreen.dart';

//import '../config/configeration.dart';
import '../../config/configeration.dart';
import '../models/movies_model.dart';
import 'homeScreen.dart';

class AlbumScreen extends StatefulWidget {
  final ContainerCard cards;
  const AlbumScreen({Key? key, required this.cards}) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 236, 236, 1),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  // borderRadius:
                  //     const BorderRadius.vertical(bottom: Radius.circular(30.0)),
                  child: Container(
                    // height: SizeConfig.defaultSize! * 20,
                    height: 400,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0)
                      ],
                    ),
                    child: Hero(
                      tag: widget.cards.imageUrl.toString(),
                      child: Image(
                          image: AssetImage(widget.cards.imageUrl.toString()),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 30.0,
                        color: Colors.black,
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                          icon: const Icon(Icons.home),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                              ))
                    ],
                  ),
                ),
                Positioned(
                  left: 8.0,
                  bottom: 380.0,
                  child: Text(
                    widget.cards.cardTitle.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 370, 0, 0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30.0)),
                      child: Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight! * 1.1,
                        // color: Color.fromARGB(255, 43, 97, 124),
                        color: const Color.fromRGBO(251, 236, 236, 1),
                        child: Expanded(
                          child: ListView.builder(
                              itemCount: widget.cards.albums.length,
                              itemBuilder: (BuildContext context, int index) {
                                widget.cards.albums[index];

                                return Stack(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.fromLTRB(40, 5, 20, 5),
                                      height: 80.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            198, 216, 220, 1),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            100.0, 15.0, 15.0, 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              widget
                                                  .cards.albums[index].moviename
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  ".  ${widget.cards.albums[index]..toString()}",
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "${widget.cards.albums[index]..toString()}  ",
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 40,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          height: 86,
                                          width: 90,
                                          decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                offset: Offset(0.0, 2.0),
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                          ),
                                          child: Image(
                                              image: AssetImage(widget
                                                  .cards.albums[index].imagUrl
                                                  .toString()),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
