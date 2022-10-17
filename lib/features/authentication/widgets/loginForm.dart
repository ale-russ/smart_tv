import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/intentFiles/button_intents.dart';
import '../../app_preference/widgets/widgets/language_selector.dart';
import '../../common/controller/global_controller.dart';
import '../../common/theme/themes.dart';
import '../controller/login_controller.dart';
import 'button.dart';
import 'checkBox.dart';
import 'login_tile.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required GlobalController globalController,
    required LoginController loginController,
    required this.formKey,
  })  : _globalController = globalController,
        _loginController = loginController,
        super(key: key);

  final GlobalController _globalController;
  final LoginController _loginController;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: true
                ? MediaQuery.of(context).size.height * 0.01
                : MediaQuery.of(context).size.height * 0.1),
        child: FocusableActionDetector(
          shortcuts: _globalController.navigationIntents,
          actions: <Type, Action<Intent>>{
            DownbuttonIntent:
                CallbackAction<DownbuttonIntent>(onInvoke: (intent) {
              if (_loginController.loginIndex <
                  _loginController.loginNodes.length) {
                FocusScope.of(context).requestFocus(_loginController
                    .loginNodes.value[++_loginController.loginIndex]);
                print("donw " + _loginController.loginIndex.toString());
                _loginController.loginNodes.refresh();
              }
            }),
            UpbuttonIntent: CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
              if (_loginController.loginIndex > 0) {
                FocusScope.of(context).requestFocus(_loginController
                    .loginNodes.value[--_loginController.loginIndex]);
              }
            }),
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.80,
            decoration: BoxDecoration(
              color: DarkModeColors.backgroundVariant,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: DarkModeColors.borderColor.withOpacity(0.1),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 30),
            child: Form(
              key: formKey,
              child: Obx(() {
                print(" text field focus is " +
                    _loginController.loginNodes.value[0].hasFocus.toString());
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.019,
                            fontWeight: FontWeight.w600),
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
                    // const SizedBox(height: 18.0),

                    LoginTextField(
                      focusNode:
                          _loginController.loginNodes.value[0], //_emailNode,
                      hint: 'Email',
                      icon: const Icon(
                        Icons.mail,
                        color: Colors.white54,
                      ),
                      //initialValue: _loginController.email,
                      controller: _loginController.emailController,
                    ),

                    const SizedBox(height: 24.0),
                    LoginTextField(
                      focusNode: _loginController.loginNodes.value[1],
                      obscure: true,
                      hint: 'Password',
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.white54,
                      ),
                      controller: _loginController.passwordController,
                    ),
                    const SizedBox(
                      height: 36.0,
                    ),
                    KeepMeIn(loginController: _loginController),
                    const SizedBox(
                      height: 36.0,
                    ),
                    Center(
                        child: KpButton(
                            loginController: _loginController,
                            formKey: formKey,
                            context: context)),
                    Center(
                      child: LangaugeSelector(),
                    )
                  ],
                );
              }),
            ),
          ),
        ));
  }
}
