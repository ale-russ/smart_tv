import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tv/features/common/services/dbAccess.dart';

import '../../profile/models/user_models.dart';

class LoginController extends GetxController {
  GlobalKey<FormState>? formKey;

  UserDetail? user;
  Users? allUsers;
  String errorMesseg = "";

  RxBool isRememberMe = false.obs;

  String? email;
  String? password;

  String? serverMessage;

  @override
  void onInit() async {
    await fetchUser();
    await rememberMe();
    super.onInit();
  }

  GlobalKey<FormState> get loginFormKey => formKey ??= GlobalKey<FormState>();

  Future<Users> fetchUser() async {
    print("fetch begins");
    final response =
        await http.get(Uri.parse("http://localhost:8080/listUsers"));
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

  void setRememberMe(bool? value) =>
      DbAccess.writeData("rememberMe", isRememberMe(value));
}


  // Future loginUser() async {
  //   // allUsers = AuthService().fetchUser();

  //   print("allUsers are $allUsers");
  // }
