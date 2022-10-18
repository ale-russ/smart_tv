// import 'dart:ffi';
// import 'dart:ui';

// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_tv/features/authentication/controller/login_controller.dart';
// import 'package:email_validator/email_validator.dart';
import 'package:smart_tv/features/authentication/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/authentication/widgets/login_tile.dart';
// import 'package:smart_tv/features/common/controller/global_controller.dart';
// import 'package:smart_tv/features/common/theme/icon_themes.dart';
import 'package:smart_tv/features/profile/controllers/user_controller.dart';
import '../../../features/common/theme/themes.dart';

import '../../../config/intentFiles/button_intents.dart';
// import '../../../config/intentFiles/up_intent.dart';
import '../../app_preference/widgets/widgets/language_selector.dart';
// import '../../common/theme/text_themes.dart';
import '../../movie_list/view/Movies.dart';
import '../widgets/remember_me.dart';
// import '../controller/login_controller.dart';

// import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) => Get.to(MoviesPage()));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
    //  Navigator.of(context).pop();
  }

  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _buttonNode;
  FocusNode? _imageNode;
  LoginController loginController = Get.put(LoginController());

  GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  bool keyboardV = false;

  String dropdownValue = languages.first;

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

  _changeNodeFocus(BuildContext context, FocusNode focus) {
    FocusScope.of(context).requestFocus(focus);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_emailNode == null) {
      _setFirstFocus(context);
    }

    final loginButton = ElevatedButton(
      focusNode: _buttonNode,
      style: ElevatedButton.styleFrom(
        primary: PrimaryColorTones.mainColor,
        // fixedSize: const Size(150, 40),
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
        loginUser();
      },
      child: Center(
          child: Text(
        "Login".tr,
        style: TextStyle(color: Colors.black),
      )),
    );

    return Scaffold(
      body: Shortcuts(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowUp): UpbuttonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown): DownbuttonIntent(),
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.75),
                  )
                ],
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                    Colors.black,
                    Colors.transparent,
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
                      Colors.black.withOpacity(0.9), BlendMode.dstATop),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: keyboardV
                    ? MediaQuery.of(context).size.height * 0.01
                    : MediaQuery.of(context).size.height * 0.1,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: BoxDecoration(
                  color: DarkModeColors.backgroundVariant,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: DarkModeColors.borderColor.withOpacity(0.1),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                child: Form(
                  key: formKey!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Actions(
                        actions: <Type, Action<Intent>>{
                          DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                            onInvoke: (intent) =>
                                _changeNodeFocus(context, _emailNode!),
                          )
                        },
                        child: Focus(
                          focusNode: _imageNode,
                          child: Container(
                            alignment: Alignment.topLeft,
                            // margin: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              'Login'.tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.019,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 8, top: 8),
                        child: Text(
                          "Please login to continue".tr,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      // const SizedBox(height: 18.0),
                      Actions(
                        actions: <Type, Action<Intent>>{
                          DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                              onInvoke: (Intent) => {
                                    _changeNodeFocus(context, _passwordNode!),
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
                        child: LoginForm(
                          emailNode: _emailNode,
                          hint: 'Email'.tr,
                          icon: const Icon(
                            Icons.mail,
                            color: Colors.white54,
                          ),
                          initialValue: loginController.email,
                          controller: loginController.emailController,
                        ),
                      ),
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
                        child: LoginForm(
                          emailNode: _passwordNode,
                          obscure: true,
                          hint: 'Password'.tr,
                          icon: const Icon(
                            Icons.lock,
                            color: Colors.white54,
                          ),
                          controller: loginController.passwordController,
                        ),
                      ),

                      const SizedBox(
                        height: 24.0,
                      ),
                      RememberMe(loginController: loginController),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Actions(
                        actions: <Type, Action<Intent>>{
                          UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                              onInvoke: (Intent) => {
                                    _changeNodeFocus(context, _passwordNode!),
                                    setState(() {
                                      keyboardV = true;
                                    }),
                                  })
                        },
                        child: Center(
                            child: SizedBox(width: 150, child: loginButton)),
                      ),
                      Center(
                        child: LangaugeSelector(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
