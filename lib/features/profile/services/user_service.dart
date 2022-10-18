import 'dart:convert';

import '../models/user_models.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Users? allUsers;

  static Future<Users> fetchUser() async {
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
}
