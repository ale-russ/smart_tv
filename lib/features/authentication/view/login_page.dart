// import 'dart:ffi';
// import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:smart_tv/features/authentication/controller/login_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/profile/controllers/user_controller.dart';

import '../../../config/intentFiles/button_intents.dart';
// import '../../../config/intentFiles/up_intent.dart';
import '../../movie_list/view/Movies.dart';
import '../controller/login_controller.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _buttonNode;
  FocusNode? _imageNode;
  LoginController loginController = Get.put(LoginController());
  UserController userController = Get.put(UserController());
  GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  bool keyboardV = false;

  _setFirstFocus(BuildContext context) {
    if (_imageNode == null) {
      _emailNode = FocusNode();
      _passwordNode = FocusNode();
      _buttonNode = FocusNode();
      _imageNode = FocusNode();
      FocusScope.of(context).requestFocus(_imageNode);
      print(_emailNode!.hasFocus);
      print(_passwordNode!.hasFocus);
      print(_buttonNode!.hasFocus);
    }
  }

  // @override
  // void dispose() {
  //   _emailNode!.dispose();
  //   _passwordNode!.dispose();
  //   _buttonNode!.dispose();
  // }

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
        primary: const Color(0xffffa600),
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
            ? userController.authenticateUser(
                    loginController.emailController.text,
                    loginController.passwordController.text)
                ? Get.to(() => MoviesPage())
                : userController.errorMesseg //LandingPage())
            : "Error Please";
      },
      child: const Center(
          child: Text(
        "Login",
        style: TextStyle(color: Colors.black),
      )),
    );

    return Scaffold(
      body: Shortcuts(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          // LogicalKeySet(LogicalKeyboardKey.arrowRight): const ActivateIntent(),
          // LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowUp): UpbuttonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown): DownbuttonIntent(),
          // LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent()
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage(
                      "assets/images/auth_bg.jpeg",
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.9), BlendMode.dstATop)),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: keyboardV
                        ? MediaQuery.of(context).size.height * 0.01
                        : MediaQuery.of(context).size.height * 0.1),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(8),
                    // border: Border.all(
                    //   color: Colors.grey.withOpacity(0.8),
                    // ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                  width: 500,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Actions(
                          actions: <Type, Action<Intent>>{
                            DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                                onInvoke: (intent) =>
                                    _changeNodeFocus(context, _emailNode!))
                          },
                          child: Focus(
                            focusNode: _imageNode,
                            child: Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(bottom: 8),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(bottom: 8, top: 8),
                          child: const Text(
                            "Please login to continue",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        Actions(
                            actions: <Type, Action<Intent>>{
                              DownbuttonIntent:
                                  CallbackAction<DownbuttonIntent>(
                                      onInvoke: (Intent) => {
                                            _changeNodeFocus(
                                                context, _passwordNode!),
                                            setState(() {
                                              keyboardV = true;
                                            }),
                                          }),
                              UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                                  onInvoke: (Intent) => {
                                        _changeNodeFocus(context, _imageNode!),
                                        setState(() {
                                          keyboardV = false;
                                        }),
                                      })
                            },
                            child: FormTextField(
                              controller: emailController,
                              emailNode: _emailNode,
                              obsecure: false,
                              hint: 'Email',
                              icon: const Icon(
                                Icons.mail,
                                color: Colors.white54,
                              ),
                              //controller: loginController.emailController
                            )),
                        const SizedBox(height: 24.0),
                        Actions(
                          actions: <Type, Action<Intent>>{
                            UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                                onInvoke: (Intent) => {
                                      _changeNodeFocus(context, _emailNode!),
                                      setState(() {
                                        keyboardV = false;
                                      }),
                                    }),
                            DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                                onInvoke: (Intent) => {
                                      _changeNodeFocus(context, _buttonNode!),
                                      setState(() {
                                        keyboardV = false;
                                      }),
                                    })
                          },
                          child: FormTextField(
                            controller: passwordController,
                            emailNode: _passwordNode,
                            obsecure: true,
                            hint: 'Password',
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.white54,
                            ),
                            //controller: loginController.passwordController,
                          ),
                        ),
                        const SizedBox(
                          height: 36.0,
                        ),
                        Actions(actions: <Type, Action<Intent>>{
                          UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                              onInvoke: (Intent) => {
                                    _changeNodeFocus(context, _passwordNode!),
                                    setState(() {
                                      keyboardV = true;
                                    }),
                                  })
                        }, child: loginButton)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // )
          ],
        ),
      ),
    );
  }
}

class FormTextField extends StatelessWidget {
  FormTextField({
    Key? key,
    FocusNode? emailNode,
    required bool obsecure,
    required this.hint,
    required this.controller,
    required this.icon,
  })  : _emailNode = emailNode,
        _obsecure = obsecure,
        super(key: key);

  final FocusNode? _emailNode;
  final bool _obsecure;
  final String? hint;
  final TextEditingController controller;

  RxBool isObscure = false.obs;

  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        obscureText: isObscure.value,
        focusNode: _emailNode,
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
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.9))),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xffffa600),
            ),
          ),
          suffixIcon: IconButton(
            icon: icon,
            onPressed: () {
              isObscure.value = !isObscure.value;
            },
          ),
          filled: true,
          fillColor: const Color(0xFF2b2b2b).withOpacity(0.9),
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

// Future SignIn() async {
//   await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: emailController.text.trim(),
//     password: passwordController.text.trim(),
//   );
// }
