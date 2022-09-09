import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:smart_tv/features/movie_list/model/movies_model.dart';

class MovieController extends GetxController {
  Content? contents;

  Future<MoviesList> fetchMovies() async {
    final response =
        await http.get(Uri.parse("http://localhost:8080/listMovies"));
    if (response.statusCode == 200) {
      return MoviesList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Falied to load movies");
    }
  }
}
