import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:smart_tv/features/authentication/view/login_page.dart';

import '../../../config/intentFiles/button_intents.dart';
import '../../app_preference/widgets/widgets/language_selector.dart';
import '../../common/controller/global_controller.dart';
import '../../common/theme/themes.dart';
import '../../movie_list/view/Movies.dart';
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
    this.googleSignIn,
  })  : _globalController = globalController,
        _loginController = loginController,
        super(key: key);

  final GlobalController _globalController;
  final LoginController _loginController;
  final GlobalKey<FormState>? formKey;

  final GoogleSignIn? googleSignIn;

  void initializeFocus(BuildContext context) {
    print("ouside timee");
    Timer(const Duration(seconds: 1), () {
      //FocusScope.of(context).requestFocus(_loginController.loginNodes.value[0]);
      //_loginController.loginNodes.refresh();
      print("timer");
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeFocus(context);
    //FocusScope.of(context).requestFocus(_loginController.loginNodes.value[0]);
    //_loginController.loginNodes.refresh();
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
      child: FocusableActionDetector(
        shortcuts: _globalController.navigationIntents,
        actions: <Type, Action<Intent>>{
          DownbuttonIntent:
              CallbackAction<DownbuttonIntent>(onInvoke: (intent) {
            print("down printing here ");
            if (_loginController.loginIndex <
                _loginController.loginNodes.length) {
              FocusScope.of(context).requestFocus(_loginController
                  .loginNodes.value[++_loginController.loginIndex]);
              print("donw " + _loginController.loginIndex.toString());
              //_loginController.loginNodes.refresh();
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
          height: MediaQuery.of(context).size.height * 0.90,
          decoration: BoxDecoration(
            color: DarkModeColors.backgroundVariant,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: DarkModeColors.borderColor.withOpacity(0.1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
          child: Form(
              key: formKey,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Login'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.019,
                            fontWeight: FontWeight.w600),
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

                    LoginTextField(
                      autoFocus: true,
                      focusNode:
                          _loginController.loginNodes.value[0], //_emailNode,
                      hint: 'Email'.tr,
                      icon: const Icon(
                        Icons.mail,
                        color: Colors.white54,
                      ),
                      //initialValue: _loginController.email,
                      controller: _loginController.emailController,
                    ),

                    const SizedBox(height: 20.0),
                    LoginTextField(
                      autoFocus: false,
                      focusNode: _loginController.loginNodes.value[1],
                      obscure: true,
                      hint: 'Password'.tr,
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.white54,
                      ),
                      controller: _loginController.passwordController,
                    ),
                    SignInWithGoogle(),
                    const SizedBox(
                      height: 28.0,
                    ),
                    KeepMeIn(loginController: _loginController),
                    const SizedBox(
                      height: 28.0,
                    ),
                    Center(
                      child: KpButton(
                          loginController: _loginController,
                          formKey: formKey,
                          context: context),
                    ),
                    Center(
                      child: LangaugeSelector(),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class SignInWithGoogle extends StatefulWidget {
  SignInWithGoogle({
    Key? key,
  }) : super(key: key);
  GlobalController globalController = Get.find();

  @override
  State<SignInWithGoogle> createState() => _SignInWithGoogleState();
}

class _SignInWithGoogleState extends State<SignInWithGoogle> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  LoginController _loginController = Get.find();

  @override
  void initState() {
    super.initState();
    print("In init state");
    try {
      widget.globalController.googleSignIn.onCurrentUserChanged
          .listen((GoogleSignInAccount? account) {
        setState(() {
          print("Account is $account");
          _currentUser = account;
        });
        if (_currentUser != null) {
          _handleGetContact(_currentUser!);
        }
      });
    } on Exception catch (err) {
      // TODO
      print("Error is $err");
    }
    widget.globalController.googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await widget.globalController.googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() =>
      widget.globalController.googleSignIn.disconnect();

  Future<void> handleSignIn() async {
    try {
      await widget.globalController.googleSignIn.signIn();
      // .then((value) {
      final GoogleSignInAccount? user = _currentUser;
      print("User after sigin in is $user");
      // if (user == null) return null;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MoviesPage(
              user: _currentUser,
            ),
          ),
        );
      }
      // else {
      //   return null;
      //   // LoginPage();
      // }
      // });
    } catch (err) {
      print("Error is $err");
    }
  }

  // Widget _buildBody() {
  //   final GoogleSignInAccount? user = _currentUser;
  //   if (user != null) {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         ListTile(
  //           leading: GoogleUserCircleAvatar(
  //             identity: user,
  //           ),
  //           title: Text(user.displayName ?? ''),
  //           subtitle: Text(user.email),
  //         ),
  //         const Text('Signed in successfully.'),
  //         Text(_contactText),
  //         ElevatedButton(
  //           onPressed: _handleSignOut,
  //           child: const Text('SIGN OUT'),
  //         ),
  //         ElevatedButton(
  //           child: const Text('REFRESH'),
  //           onPressed: () => _handleGetContact(user),
  //         ),
  //       ],
  //     );
  //   } else {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         const Text('You are not currently signed in.'),
  //         ElevatedButton(
  //           onPressed: _handleSignIn,
  //           child: const Text('SIGN IN'),
  //         ),
  //       ],
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final GoogleSignInAccount? user = _currentUser;
    return Container(
      child: TextButton(
        focusNode: _loginController.loginNodes.value[2],
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                _loginController.loginNodes.value[2].hasFocus
                    ? Colors.transparent
                    : Colors.transparent)),
        onPressed: handleSignIn,
        child: Text(
          "Sign in with Google",
          style: TextStyle(
            color: _loginController.loginNodes.value[2].hasFocus
                ? Colors.amber
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
