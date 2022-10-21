import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_tizen/google_sign_in_tizen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_tv/config/intentFiles/button_intents.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/app_preference/widgets/widgets/language_translation.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/authentication/view/login_page.dart';
import 'features/authentication/view/translation.dart';
import 'package:smart_tv/features/common/controller/initialBinding.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';

import 'features/common/services/dbAccess.dart';
import 'features/movie_list/view/Movies.dart';
import 'firebase_options.dart';
import 'creds.dart' as creds;

void main(List<String>? args) async {
  debugPrint('args: $args');

  GoogleSignInTizen.setCredentials(
    // clientId: clientId,
    clientId: GetPlatform.isAndroid ? creds.clientId : creds.tvClient,
    clientSecret: creds.clientSecret,
  );

  await preLauncherSetup();

  WidgetsFlutterBinding.ensureInitialized();
  // if (GetPlatform.isAndroid) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   await FirebaseAuth.instance.useAuthEmulator('localhot', 9099);
  // }
  //KbinitialBinding().dependencies;
  runApp(MyApp(
    navigatorKeyTizen: GoogleSignInTizen.navigatorKey,
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends GetView<GlobalController> {
  MyApp({Key? key, this.navigatorKeyTizen}) : super(key: key);
  final GlobalKey<NavigatorState>? navigatorKeyTizen;

  GlobalController? globalController = Get.put(GlobalController());
  //KbinitialBinding()
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKeyTizen,
      // GetPlatform.isAndroid ? navigatorKey : navigatorKeyTizen,
      translations: translate(),
      locale: Locale('ti', 'Eri'),
      fallbackLocale: Locale('en', 'US'),
      title: 'Kabbee Movies',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "WorkSans"),
      home: LoginPage(
        googleSignIn: globalController!.googleSignIn,
      ),
      // home: MoviesPage(),

      //initialRoute: MoviesPage(),
      initialBinding: KbinitialBinding(),

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
