// import 'dart:ffi';
// import 'dart:ui';

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:smart_tv/features/authentication/controller/login_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/authentication/widgets/login_tile.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/theme/icon_themes.dart';
import 'package:smart_tv/features/profile/controllers/user_controller.dart';
import '../../../features/common/theme/themes.dart';

import '../../../config/intentFiles/button_intents.dart';
// import '../../../config/intentFiles/up_intent.dart';
import '../../app_preference/widgets/widgets/language_selector.dart';
import '../../common/theme/text_themes.dart';
import '../../movie_list/view/Movies.dart';
import '../controller/login_controller.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/button.dart';
import '../widgets/checkBox.dart';
import '../widgets/loginForm.dart';

class LoginPage extends StatelessWidget {
  final _loginController = Get.put(LoginController());
  final _globalController = Get.put(GlobalController());
  final _intentController = Get.put(IntentController());
  GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  Rx<FocusNode>? testing = FocusNode().obs;
  // bool keyboardV = false;

  // String dropdownValue = languages.first;
  @override
  Widget build(BuildContext context) {
    initializeFocus(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          backGroundContianer(context),

          LoginForm(
              globalController: _globalController,
              loginController: _loginController,
              formKey: formKey),
          // )
        ],
      ),
    );
  }

  void initializeFocus(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      FocusScope.of(context).autofocus(_loginController.loginNodes.value[2]);
      print("timer");
    });
  }

  void moveUp(BuildContext context) {
    if (_loginController.loginIndex > 0) {
      FocusScope.of(context).requestFocus(
          _loginController.loginNodes.value[--_loginController.loginIndex]);
    }
  }

  void moveDown(BuildContext context) {
    print("donw");
    if (_loginController.loginIndex < _loginController.loginNodes.length) {
      FocusScope.of(context).requestFocus(
          _loginController.loginNodes.value[++_loginController.loginIndex]);
    }
  }

  Container backGroundContianer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75))
        ],
        gradient: LinearGradient(
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
            Colors.black,
            Colors.transparent,

            // Theme.of(context).scaffoldBackgroundColor.withOpacity(1.0)
          ],
          stops: const [0.1, 0.0, 0.7, 0],
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ),
        image: DecorationImage(
            image: const AssetImage(
              "assets/images/auth_bg.jpeg",
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.9), BlendMode.dstATop)),
      ),
    );
  }
}






// Future SignIn() async {
//   await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: emailController.text.trim(),
//     password: passwordController.text.trim(),
//   );
// }
