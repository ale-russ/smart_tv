import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/authentication/controller/login_controller.dart';

import '../../common/theme/themes.dart';

class LoginTextField extends StatelessWidget {
  LoginTextField({
    Key? key,
    this.focusNode,
    this.obscure = false,
    required this.hint,
    required this.controller,
    required this.icon,
    this.initialValue = "",
  }) : super(key: key);
  final FocusNode? focusNode;
//  final FocusNode _emailNode;
  //FocusNode? _iconFocus;
  bool? obscure;
  final String? hint;
  final String? initialValue;
  final TextEditingController controller;

  LoginController loginController = Get.put(LoginController());

  // RxBool isObscure = false.obs;

  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.04,
      child: TextFormField(
        textInputAction: TextInputAction.done,
        // autofocus: true,
        // initialValue: initialValue!,
        // obscureText: isObscure.value,
        obscureText: obscure!,
        focusNode: focusNode,
        controller: controller,
        style: const TextStyle(fontSize: 16.0, color: Colors.white60),
        validator: hint == 'Email'
            ? (email) {
                if (!EmailValidator.validate(email!)) {
                  return "Invalide email address ";
                } else {
                  return null;
                }
              }
            : (password) {
                if (password!.length < 6 ||
                    !password.contains(RegExp(r'[0-9]'))) {
                  return "Password should be numbers with 6 characters";
                } else {
                  return null;
                }
              },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: focusNode!.hasFocus
                ? BorderSide(color: DarkModeColors.borderColor)
                : BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: DarkModeColors.borderColor,
            ),
          ),
          suffixIcon: Focus(
            canRequestFocus: false,
            child: IconButton(
              icon: icon,
              onPressed: () {
                print("Obscure is $obscure");
                // isObscure.value = !isObscure.value;
                // _iconFocus!.canRequestFocus = false;
              },
            ),
          ),
          filled: true,
          fillColor: DarkModeColors.surfaceColor.withAlpha(255),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white60),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
