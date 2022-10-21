// import 'dart:ffi';
// import 'dart:ui';

import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_tv/features/authentication/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';

import '../widgets/loginForm.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key, this.googleSignIn}) : super(key: key);

  final _loginController = Get.put(LoginController());
  GlobalController _globalController = Get.put(GlobalController());
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();

  final GoogleSignIn? googleSignIn;

  // bool keyboardV = false;

  // String dropdownValue = languages.first;
  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // initializeFocus(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          backGroundContianer(context),

          LoginForm(
            globalController: _globalController,
            loginController: _loginController,
            formKey: formKey,
            googleSignIn: googleSignIn,
          ),
          // )
        ],
      ),
    );
  }

  void initializeFocus(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      FocusScope.of(context).requestFocus(_loginController.loginNodes.value[0]);
      _loginController.loginNodes.refresh();
      print("timer");
    });
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

// Future SignIn() async {
//   await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: emailController.text.trim(),
//     password: passwordController.text.trim(),
//   );
// }
}
