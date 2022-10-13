import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/services/dbAccess.dart';
import 'package:smart_tv/features/profile/services/user_service.dart';

import '../../profile/models/user_models.dart';

class LoginController extends GetxController {
  GlobalKey<FormState>? formKey;

  UserDetail? user;
  RxString errorMesseg = "".obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isRememberMe = false.obs;

  String? email;
  String? password;

  @override
  void onInit() async {
    super.onInit();
    await UserService.fetchUser();
    await rememberMe();
  }

  GlobalKey<FormState> get loginFormKey => formKey ??= GlobalKey<FormState>();

  authenticateUser(String emailAddress, String password) {
    printInfo(info: "users are ${UserService.allUsers}");
    for (var lUser in UserService.allUsers!.users!) {
      if (lUser.email == emailAddress) {
        user = lUser;
        print(user!.email);
        DbAccess.userDB
          ..put("email", user!.email)
          ..put("FirstName", user!.firtName)
          ..put("LastName", user!.lastName)
          ..put("country", user!.country)
          ..put("gender", user!.sex)
          ..put("dateOfBirth", user!.dateOfBirth);

        return true;
      } else {
        errorMesseg =
            "User Not Found, Please check your email address and try again".obs;
        print("error is $errorMesseg");
        return false;
      }
    }
    if (isRememberMe.isFalse) email = null;
  }

  Future rememberMe() async {
    isRememberMe(DbAccess.readData("rememberMe", defaultValue: false));
    if (isRememberMe.isTrue) email = DbAccess.readData("email");
  }

  void setRememberMe(bool? value) =>
      DbAccess.writeData("rememberMe", isRememberMe(value));
}


  // Future loginUser() async {
  //   // allUsers = AuthService().fetchUser();

  //   print("allUsers are $allUsers");
  // }
