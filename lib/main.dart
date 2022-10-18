import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';

import 'features/common/services/dbAccess.dart';
import 'features/movie_list/view/Movies.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main(List<String>? args) async {
  debugPrint('args: $args');

  await preLauncherSetup();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends GetView<GlobalController> {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kabbee Movies',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "WorkSans"),
      // home: const LoginPage(),
      home: MoviesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future preLauncherSetup() async {
  GetPlatform.isAndroid || GetPlatform.isDesktop
      ? await DbAccess.initHive()
      : null;

  Get.put(GlobalController(), permanent: true);
}
