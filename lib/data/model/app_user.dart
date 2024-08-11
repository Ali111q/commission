// To parse this JSON data, do
//
//     final appUser = appUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AppUser appUserFromJson(String str) => AppUser.fromJson(json.decode(str));

String appUserToJson(AppUser data) => json.encode(data.toJson());

class AppUser {
  String id;
  String fullName;
  String email;
  Role role;
  String token;
  dynamic garageId;
  dynamic garageName;
  bool isActive;
  DateTime creationDate;
  bool deleted;

  AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.token,
    required this.garageId,
    required this.garageName,
    required this.isActive,
    required this.creationDate,
    required this.deleted,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        role: Role.fromJson(json["role"]),
        token: json["token"],
        garageId: json["garageId"],
        garageName: json["garageName"],
        isActive: json["isActive"],
        creationDate: DateTime.parse(json["creationDate"]),
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "role": role.toJson(),
        "token": token,
        "garageId": garageId,
        "garageName": garageName,
        "isActive": isActive,
        "creationDate": creationDate.toIso8601String(),
        "deleted": deleted,
      };
}

class Role {
  String id;
  String name;
  DateTime creationDate;
  bool deleted;

  Role({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.deleted,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        creationDate: DateTime.parse(json["creationDate"]),
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "creationDate": creationDate.toIso8601String(),
        "deleted": deleted,
      };
}
