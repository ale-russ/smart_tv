import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'features/movie_list/view/Movies.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main(List<String>? args) async {
  debugPrint('args: $args');

  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAuth.instance.useAuthEmulator('localhot', 9099);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
