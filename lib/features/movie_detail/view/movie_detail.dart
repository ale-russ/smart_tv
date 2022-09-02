import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  MovieDetail({Key? key, required this.movieTitle, required this.movieUrl})
      : super(key: key);
  final String movieUrl;
  final String movieTitle;

  @override
  State<MovieDetail> createState() => _MovieDetailState(movieTitle, movieUrl);
}

class _MovieDetailState extends State<MovieDetail> {
  final String movieUrl;
  final String movieTitle;
  bool clicked = false;
  _MovieDetailState(this.movieUrl, this.movieTitle);
  //_MovieDetailState();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.80,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Image(
                image: AssetImage(movieTitle),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.height * 0.06,
              height: MediaQuery.of(context).size.width * 0.03,
              color: Colors.grey,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    clicked = !clicked;
                  });
                  print("clicked");
                },
                child: Icon(
                  !clicked ? Icons.play_arrow : Icons.pause,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
