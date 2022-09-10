import 'package:flutter/material.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/movie_list/view/Movies.dart';
import 'package:smart_tv/features/movie_list/view/landingPage.dart';
import 'package:smart_tv/features/screen/movieScreen.dart';
import 'package:smart_tv/features/upcoming_movies/upcoming_movies.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        // LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent(),
        // LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent(),
        // LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent(),
        // LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent(),
        // LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent()
      },
      child: GetMaterialApp(
        title: 'Kabbe Movies',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: LoginPage(), //const HomeScreen()
        // home: LandingPage(),
        home: const LoginPage(), //MoviesPage(), //
        // home: HomePage(title: "Login page"),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginPage(),
    );
  }
}
