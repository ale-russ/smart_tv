import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tv/features/common/services/dbAccess.dart';

import '../../profile/models/user_models.dart';

class LoginController extends GetxController {
  GlobalKey<FormState>? formKey;

  RxList<FocusNode> loginNodes = <FocusNode>[].obs;

  UserDetail? user;
  Users? allUsers;
  String errorMesseg = "";
  int loginIndex = 0;
  Rx<FocusNode>? testing123 = FocusNode().obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isRememberMe = true.obs;

  String? email;
  String? password;

  String? serverMessage;

  @override
  void onInit() async {
    initializeNodes();
    print("coning0");
    //await fetchUser();
    await rememberMe();
    print("coning0");

    super.onInit();
  }

  GlobalKey<FormState> get loginFormKey => formKey ??= GlobalKey<FormState>();

  Future<Users> fetchUser() async {
    print("fetch begins 123");
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8080/listUsers"));
    // await http.get(Uri.parse("http://10.0.2.2:8080/listUsers"));

    if (response.statusCode == 200) {
      allUsers = Users.fromJson(jsonDecode(response.body));
      return Users.fromJson(jsonDecode(response.body));
    } else {
      print("Error is ${response.hashCode}");
      throw Exception("Failed to load Users");
    }
  }

  authenticateUser(String emailAddress, String password) {
    for (var lUser in allUsers!.users!) {
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
        errorMesseg = "User Not Found, Please check your email address";
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
    for (var i = 0; i < 4; i++) {
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
    DbAccess.writeData("rememberMe", isRememberMe(value));
  }
}


  // Future loginUser() async {
  //   // allUsers = AuthService().fetchUser();

  //   print("allUsers are $allUsers");
  // }
