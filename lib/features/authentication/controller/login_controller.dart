import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/authentication/service/login_service.dart';
import 'package:smart_tv/features/common/services/dbAccess.dart';

import '../../profile/models/user_models.dart';

class LoginController extends GetxController {
  UserDetail? user;
  Users? allUsers;
  String errorMesseg = "";

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isRememberMe = false.obs;

  String? email;
  String? password;

  @override
  void onInit() async {
    await rememberMe();
    super.onInit();
  }

  Future loginUser() async {
    // allUsers = AuthService().fetchUser();

    print("allUsers are $allUsers");
  }

  Future rememberMe() async {
    DbAccess.userDB
      ..put("email", email)
      ..put("password", password);

    isRememberMe(DbAccess.readData("rememberMe", defaultValue: false));

    if (isRememberMe.isTrue) email = DbAccess.readData("email");
  }

  void setRememberMe(bool? value) =>
      DbAccess.writeData("rememberMe", isRememberMe(value));
}
