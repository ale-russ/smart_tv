import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:smart_tv/features/movie_list/model/movies_model.dart';

var url = "http://localhost:8080/movieList";

class MovieService {
  static Future<MoviesList> fetchMovies() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return MoviesList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to load");
    }
  }

// Future<Content>? fetchMovies() async {
//   var response = await http.get(Uri.parse(url));
//   return moviesFromJson(response.body);
// }

//  Future<Content> fetchMovies {
//   var url = Uri.https("http://localhost:8080", "/listMovies");

  // static Future<Content> fetchMovies() async {
  //   final response =
  //       await http.get(Uri.parse("http://localhost:8080/listMovies"));
  //   print('response is $response');
  //   return moviesFromJson(jsonDecode(response.body));
  // }

}

// }

