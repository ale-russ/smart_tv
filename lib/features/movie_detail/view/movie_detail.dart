import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  MovieDetail({
    Key? key,
    required this.imageUrl,
    required this.movieUrl,
    required this.movieTitle,
  }) : super(key: key);

  final String movieUrl;
  final String imageUrl;
  final String movieTitle;

  @override
  State<MovieDetail> createState() => _MovieDetailState(imageUrl, movieUrl);
}

class _MovieDetailState extends State<MovieDetail> {
  final String movieUrl;
  final String imageUrl;
  bool clicked = false;
  _MovieDetailState(this.movieUrl, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(top: 30),
                height: MediaQuery.of(context).size.height * 0.80,
                width: MediaQuery.of(context).size.width * 0.90,
                child: Image(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                onPressed: () {
                  setState(
                    () {
                      clicked = !clicked;
                    },
                  );
                },
                child: !clicked
                    ? const Icon(
                        Icons.play_arrow,
                        size: 100,
                      )
                    : const Icon(
                        Icons.pause,
                        size: 100,
                      ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              movieUrl,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
