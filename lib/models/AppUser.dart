// To parse this JSON data, do
//
//     final appUser = appUserFromMap(jsonString);

import 'dart:convert';

AppUser appUserFromMap(String str) => AppUser.fromMap(json.decode(str));

String appUserToMap(AppUser data) => json.encode(data.toMap());

class AppUser {
  AppUser({this.username, this.language, this.accessCode, this.isActive});

  String username;
  String language;
  String accessCode;
  bool isActive;

  factory AppUser.fromMap(Map<String, dynamic> json) => AppUser(
        username: json["username"] == null ? null : json["username"],
        language: json["language"] == null ? null : json["language"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        accessCode: json["access_code"] == null ? null : json["access_code"],
      );

  Map<String, dynamic> toMap() => {
        "username": username == null ? null : username,
        "language": language == null ? null : language,
        "is_active": isActive == null ? null : isActive,
        "access_code": accessCode == null ? null : accessCode,
      };
}
