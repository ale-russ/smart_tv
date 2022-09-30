import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tv/features/profile/models/user_models.dart';

class UserController extends GetxController {
  UserDetail? user;
  Users? allUsers;
  String errorMesseg = "";

  @override
  void onInit() async {
    await fetchUser();
  }

  Future<Users> fetchUser() async {
    //print("fetch begins");
    final response =
        await http.get(Uri.parse("http://localhost:8080/listUsers"));

    if (response.statusCode == 200) {
      allUsers = Users.fromJson(jsonDecode(response.body));
      return Users.fromJson(jsonDecode(response.body));
    } else {
      print(response.hashCode);
      throw Exception("Failed to load Movies");
    }
  }

  authenticateUser(String email, String password) {
    for (var lUser in allUsers!.users!) {
      if (lUser.email == email) {
        user = lUser;
        print(user!.email);
        return true;
      }
    }
    errorMesseg = "Wrong email address";
    return false;
  }
}
