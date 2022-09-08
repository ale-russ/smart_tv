// import 'dart:ffi';
import 'dart:ui';

import 'package:smart_tv/features/authentication/controller/login_controller.dart';
import 'package:smart_tv/features/movie_list/view/Movies.dart';
import 'package:smart_tv/features/movie_list/view/landingPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
//import 'package:password_validator/password_validator.dart';

import '../controller/login_controller.dart';

class LeftbuttonIntent extends Intent {}

class RightbuttonIntent extends Intent {}

class UpbuttonIntent extends Intent {}

class DownbuttonIntent extends Intent {}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _buttonNode;
  LoginController loginController = Get.put(LoginController());
  GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  _setFirstFocus(BuildContext context) {
    if (_emailNode == null) {
      _emailNode = FocusNode();
      _passwordNode = FocusNode();
      _buttonNode = FocusNode();
      FocusScope.of(context).requestFocus(_emailNode);
    }
  }

  _changeNodeFocus(BuildContext context, FocusNode focus) {
    FocusScope.of(context).requestFocus(focus);
  }

  @override
  Widget build(BuildContext context) {
    if (_emailNode == null) {
      _setFirstFocus(context);
    }

    final loginButton = ElevatedButton(
      focusNode: _buttonNode,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 35),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      onPressed: () {
        formKey!.currentState!.validate()
            ? Get.to(() => MoviesPage())
            : "Error Please";
      },
      child: const Center(child: Text("Login")),
    );

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              //color: Colors.black54,
              image: DecorationImage(
                  image: const AssetImage(
                    "assets/images/background3.jpg",
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.9), BlendMode.dstATop)),
            ),
            //child: Text("this is the main text I am going to use "),
          ),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Shortcuts(
                  shortcuts: {
                    LogicalKeySet(LogicalKeyboardKey.select):
                        const ActivateIntent(),
                    LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                        LeftbuttonIntent(),
                    LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                        RightbuttonIntent(),
                    LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                        UpbuttonIntent(),
                    LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                        DownbuttonIntent(),
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              image: AssetImage(
                                "assets/images/logo.png",
                              ),
                              width: 70,
                              height: 70,
                            ),
                            const SizedBox(height: 18.0),
                            Actions(
                                actions: <Type, Action<Intent>>{
                                  DownbuttonIntent:
                                      CallbackAction<DownbuttonIntent>(
                                          onInvoke: (Intent) =>
                                              _changeNodeFocus(
                                                  context, _emailNode!))
                                },
                                child: FormTextField(
                                  emailNode: _emailNode,
                                  obsecure: false,
                                  hint: 'Email',
                                  controller: loginController.emailController,
                                  type: DownbuttonIntent,
                                )),
                            const SizedBox(height: 24.0),
                            FormTextField(
                              emailNode: _passwordNode,
                              obsecure: true,
                              hint: 'Password',
                              controller: loginController.passwordController,
                              type: DownbuttonIntent,
                            ),
                            const SizedBox(
                              height: 36.0,
                            ),
                            loginButton
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FormTextField extends StatelessWidget {
  const FormTextField({
    Key? key,
    required FocusNode? emailNode,
    required bool obsecure,
    required this.hint,
    required this.controller,
    // required this.intent,
    required this.type,
  })  : _emailNode = emailNode,
        _obsecure = obsecure,
        super(key: key);

  final FocusNode? _emailNode;
  final bool _obsecure;
  final String? hint;
  final TextEditingController controller;

  final Type type;

  onChangeFocus(BuildContext context, FocusNode? focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        type: CallbackAction<ButtonActivateIntent>(
            onInvoke: onChangeFocus(context, _emailNode))
      },
      child: Focus(
        focusNode: _emailNode,
        child: TextFormField(
          obscureText: _obsecure,
          focusNode: _emailNode,
          controller: controller,
          style: const TextStyle(fontSize: 16.0),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: hint,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ),
      ),
    );
  }
}
