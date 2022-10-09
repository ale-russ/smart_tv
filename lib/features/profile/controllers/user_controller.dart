import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tv/features/common/services/dbAccess.dart';
import 'package:smart_tv/features/profile/models/user_models.dart';

class UserController extends GetxController {
  UserDetail? user;
  Users? allUsers;
  String errorMesseg = "";

  @override
  void onInit() async {
    super.onInit();
    await fetchUser();
  }

  Future<Users> fetchUser() async {
    print("fetch begins");
    final response =
        // await http.get(Uri.parse("http://localhost:8080/listUsers"));
        await http.get(Uri.parse("http://10.0.2.2:8080/listUsers"));

    print("Response in fetchUser is ${response.hashCode}");

    if (response.statusCode == 200) {
      allUsers = Users.fromJson(jsonDecode(response.body));
      return Users.fromJson(jsonDecode(response.body));
    } else {
      print("Error is ${response.hashCode}");
      throw Exception("Failed to load Users");
    }
  }

  authenticateUser(String email, String password) {
    print("Users are $allUsers");
    for (var lUser in allUsers!.users!) {
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
    errorMesseg = "Wrong email address";
    return false;
  }
}
