// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.users,
  });

  List<UserDetail>? users;

  Future<String> getData() {
    return rootBundle.loadString('user.json');
  }

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        users: List<UserDetail>.from(
            json["users"].map((x) => UserDetail.fromJson(x))),
      );
  // factory Users.fromJson(Map<String, dynamic> json) => Users(users: List<UserDetail>.from(getData()));

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class UserDetail {
  UserDetail({
    this.email,
    this.firtName,
    this.lastName,
    this.sex,
    this.country,
    this.dateOfBirth,
  });

  String? email;
  String? firtName;
  String? lastName;
  String? sex;
  String? country;
  String? dateOfBirth;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        email: json["email"],
        firtName: json["firt_name"],
        lastName: json["last_name"],
        sex: json["sex"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firt_name": firtName,
        "last_name": lastName,
        "sex": sex,
        "country": country,
        "dateOfBirth": dateOfBirth
      };
}
