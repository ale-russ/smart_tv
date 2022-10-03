// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_if_null_operators, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';

import '../controller/movie_controller.dart';

import 'package:smart_tv/features/movie_list/widgets/movies_tile.dart';

class TopRated extends StatefulWidget {
  final List toprated;

  const TopRated({Key? key, required this.toprated}) : super(key: key);

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  MoviesController controller = Get.find();
  final IntentController _intentController = Get.find();

  @override
  void initState() {
    if (_intentController.topRatedNodes!.isEmpty) {
      for (var i = 0; i < controller.topratedmovies.length; i++) {
        var temp = FocusNode();
        _intentController.topRatedNodes!.add(temp);
      }
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: MoviesTile(
        movie: widget.toprated,
        title: "Top Rated Movies",
        nodes: _intentController.topRatedNodes!,
        borderColor: Colors.grey.withOpacity(0.3),
        scrollController: _intentController.topRatedScrollController.value,
      ),
    );
  }
}
