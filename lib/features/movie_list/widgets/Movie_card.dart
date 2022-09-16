import 'package:flutter/material.dart';

class Movie_card extends StatelessWidget {
  const Movie_card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://i.pinimg.com/236x/a7/bf/b8/a7bfb8ae91e72da82248bdd3361a12f6.jpg'),
              fit: BoxFit.cover)),
    );
  }
}
