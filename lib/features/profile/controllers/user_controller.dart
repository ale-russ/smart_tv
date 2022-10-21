// import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smart_tv/features/common/services/dbAccess.dart';
import 'package:smart_tv/features/profile/models/user_models.dart';

import '../services/user_service.dart';

// class UserController extends GetxController {
//   UserDetail? user;
//   String errorMesseg = "";

//   @override
//   void onInit() async {
//     super.onInit();
//     await UserService.fetchUser();
//   }
class UserController extends GetxController {
  UserDetail? user;
  RxString errorMesseg = "".obs;
  RxList<dynamic>? profileNodes = [].obs;
  RxList<dynamic>? sideNodes = [].obs;

  @override
  void onInit() async {
    super.onInit();
    initializNodes();
    await UserService.fetchUser();
  }

  authenticateUser(String email, String password) {
    print("Users are ${UserService.allUsers}");

    for (var lUser in UserService.allUsers!.users!) {
      if (lUser.email == email) {
        user = lUser;
        print(user!.email);
        DbAccess.writeData("email", user!.email);
        DbAccess.writeData("FirstName", user!.firtName);
        DbAccess.writeData("LastName", user!.lastName);
        DbAccess.writeData("country", user!.country);
        DbAccess.writeData("gender", user!.sex);
        // DbAccess.writeData("BOD", user!.dateOfBirth);

        return true;
      }
    }
    errorMesseg = "Wrong email address".obs;
    return false;
  }

  initializNodes() {
    for (var i = 0; i < 7; i++) {
      profileNodes!.add(FocusNode(debugLabel: "profile node $i"));
    }
    for (var i = 0; i < 5; i++) {
      sideNodes!.add(FocusNode(debugLabel: "side node $i"));
      print(sideNodes!.value[i]);
    }
  }
}
