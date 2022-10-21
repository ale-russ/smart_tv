import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/theme/themes.dart';
import '../../movie_list/view/Movies.dart';
import '../controller/login_controller.dart';

class KpButton extends StatelessWidget {
  KpButton({
    Key? key,
    required this.loginController,
    required this.formKey,
    required this.context,
    //required LoginController loginController,
  }) : super(key: key);

  final LoginController loginController;
  final GlobalKey<FormState>? formKey;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        focusNode: loginController.loginNodes.value[4],
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
              ? loginUser() //LandingPage())
              : loginController.errorMesseg;
        },
        child: Center(
            child: Text(
          "Login".tr,
          style: TextStyle(color: Colors.black),
        )),
      ),
    );
  }

  void loginUser() {
    print("Error message is ${loginController.errorMesseg}");

    if (formKey!.currentState!.validate()) {
      loginController.authenticateUser(
        loginController.emailController.text,
        loginController.passwordController.text,
      )
          ? Get.to(() => MoviesPage())
          : ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: DarkModeColors.backgroundVariant,
                content: Text(
                  textAlign: TextAlign.center,
                  "${loginController.errorMesseg}",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            );
    }
  }
}
