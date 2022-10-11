import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/theme/themes.dart';
import '../../movie_list/view/Movies.dart';
import '../controller/login_controller.dart';

class KpButton extends StatelessWidget {
  const KpButton({
    Key? key,
    required LoginController loginController,
    required this.formKey,
    required this.context,
    //required LoginController _loginController,
  })  : _loginController = loginController,
        super(key: key);

  final LoginController _loginController;
  final GlobalKey<FormState>? formKey;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      focusNode: _loginController.loginNodes.value[3],
      onFocusChange: (bool) {
        print("button true");
      },
      style: ElevatedButton.styleFrom(
        primary: PrimaryColorTones.mainColor,
        fixedSize: const Size(150, 40),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      onPressed: () {
        formKey!.currentState!.validate()
            ? _loginController.authenticateUser(
                    _loginController.emailController.text,
                    _loginController.passwordController.text)
                ? Get.to(() => MoviesPage())
                : _loginController.errorMesseg //LandingPage())
            : _loginController.errorMesseg;
      },
      child: const Center(
          child: Text(
        "Login",
        style: TextStyle(color: Colors.black),
      )),
    );
  }
}
