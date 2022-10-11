import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_tv/config/intentFiles/button_intents.dart';
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
  // if (GetPlatform.isAndroid) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   await FirebaseAuth.instance.useAuthEmulator('localhot', 9099);
  // }

  runApp(const MyApp());
}

class MyApp extends GetView<GlobalController> {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight): RightbuttonIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftbuttonIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowUp): UpbuttonIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowDown): DownbuttonIntent(),
        LogicalKeySet(LogicalKeyboardKey.goBack): BackButtonIntent()
      },
      title: 'Kabbee Movies',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "WorkSans"),
      home: LoginPage(),
      //home: MoviesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future preLauncherSetup() async {
  GetPlatform.isAndroid ? await DbAccess.initHive() : null;

  Get.put(GlobalController(), permanent: true);
}
