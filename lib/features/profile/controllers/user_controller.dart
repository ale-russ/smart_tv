import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tv/features/profile/models/user_models.dart';

class UserController extends GetxController {
  UserDetail? user;

  Future<Users> fetchUser() async {
    final response =
        await http.get(Uri.parse("http://localhost:8080/listUsers"));
    if (response.hashCode == 200) {
      return Users.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load Movies");
    }
  }
}
