import 'package:flutter/material.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'features/movie_list/view/Movies.dart';

void main(List<String>? args) {
  debugPrint('args: $args');
  WidgetsFlutterBinding.ensureInitialized();
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
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowDown): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowUp): const ActivateIntent(),
        // LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent()
      },
      child: GetMaterialApp(
        title: 'Kabbe Movies',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "WorkSans"),
        // home: const LoginPage(),
        home: MoviesPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
