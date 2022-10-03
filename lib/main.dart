import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';

import 'features/common/services/dbAccess.dart';

void main(List<String>? args) async {
  debugPrint('args: $args');

  await preLauncherSetup();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends GetView<GlobalController> {
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
        home: const LoginPage(),
        // home: MoviesPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

Future preLauncherSetup() async {
  await DbAccess.initHive();

  Get.put(GlobalController(), permanent: true);
}
