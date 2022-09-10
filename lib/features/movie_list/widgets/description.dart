import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, lauchOn;

  const Description(
      {Key? key,
      required this.bannerurl,
      required this.description,
      required this.lauchOn,
      required this.name,
      required this.posterurl,
      required this.vote})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GetPlatform.isDesktop || GetPlatform.isWeb
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : const SizedBox.shrink()),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          SizedBox(
              height: 500,
              child: Stack(
                children: [
                  Positioned(
                    child: SizedBox(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        bannerurl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    child: Modified_text(
                        text: '⭐Average Rating - $vote',
                        color: Colors.white60,
                        size: 20),
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: Modified_text(text: name, color: Colors.white60, size: 15),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: Modified_text(
                text: 'Releasing On - $lauchOn',
                color: Colors.white60,
                size: 15),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                height: 200,
                width: 100,
                child: Image.network(posterurl),
              ),
              Flexible(
                child: Container(
                  child: Modified_text(
                      text: description, color: Colors.white60, size: 15),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
