// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';

import 'description.dart';
import 'package:smart_tv/features/movie_list/widgets/movies_tile.dart';

class TV extends StatefulWidget {
  final List tv;

  const TV({Key? key, required this.tv}) : super(key: key);

  @override
  State<TV> createState() => _TVState();
}

class _TVState extends State<TV> {
  MoviesController controller = Get.find();

  @override
  void initState() {
    if (controller.tvShowsNodes!.isEmpty) {
      for (var i = 0; i < controller.tv.length; i++) {
        var temp = FocusNode();
        controller.tvShowsNodes!.add(temp);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: MoviesTile(
        movie: widget.tv,
        title: "Tv Shows",
        nodes: controller.tvShowsNodes,
        borderColor: Colors.grey.withOpacity(0.3),
        scrollController: controller.tvShowScrollController,
      ),
    );
  }
}
