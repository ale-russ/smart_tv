
import 'dart:developer';

import 'package:get/get.dart';

import 'package:smart_tv/features/common/services/dbAccess.dart';
import 'package:smart_tv/features/profile/models/user_models.dart';

import '../service/user_service.dart';

class UserController extends GetxController {
  UserDetail? user;
  Users? allUsers;
  String errorMesseg = "";
  UserService? userService;
  @override
  void onInit() async {
    super.onInit();
    await userService!.fetchUser();
  }

  authenticateUser(String email, String password) {
    print("Users are $allUsers");
    for (var lUser in allUsers!.users!) {
      if (lUser.email == email) {
        user = lUser;
        print(user!.email);
        DbAccess.writeData(email, email);
        return true;
      }
    }
    errorMesseg = "Wrong email address";
    return false;
  }
}


