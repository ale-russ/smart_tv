import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/services/dbAccess.dart';
import 'package:smart_tv/features/profile/services/user_service.dart';

import '../../profile/models/user_models.dart';

class LoginController extends GetxController {
  GlobalKey<FormState>? formKey;

  RxList<FocusNode> loginNodes = <FocusNode>[].obs;

  UserDetail? user;
  Users? allUsers;
  String errorMesseg = "";
  int loginIndex = 0;
  Rx<FocusNode>? testing123 = FocusNode().obs;
  // RxString errorMesseg = "".obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isRememberMe = false.obs;

  String? email;
  String? password;

  @override
  void onInit() async {
    initializeNodes();
    print("coning0");
    //await fetchUser();
    await rememberMe();
    print("coning0");

    super.onInit();
    await UserService.fetchUser();
    await rememberMe();
  }

  GlobalKey<FormState> get loginFormKey => formKey ??= GlobalKey<FormState>();

  authenticateUser(String emailAddress, String password) {
    printInfo(info: "users are ${UserService.allUsers!.users![3].email}");
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
        errorMesseg = "user_not_found".tr;
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

  initializeNodes() async {
    for (var i = 0; i < 6; i++) {
      loginNodes.add(FocusNode(debugLabel: "loginNode $i"));
      print(loginNodes[i]);
    }
    testing123!.value = FocusNode(debugLabel: "testing node");
    print("this is hte node " + testing123!.value.toString());
    //Get.focusScope!.requestFocus(loginNodes.value[0]);
    //FocusScope.of(context).requestFocus(l)
  }

  void setRememberMe(bool? value) {
    isRememberMe.value = value!;
    isRememberMe.refresh();
    print("remembre ehre" + value.toString());
    DbAccess.writeData("rememberMe", isRememberMe(value));
  }
}


  // Future loginUser() async {
  //   // allUsers = AuthService().fetchUser();

  //   print("allUsers are $allUsers");
  // }
