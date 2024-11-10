// To parse this JSON data, do
//
//     final plateCharecter = plateCharecterFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PlateCharecterModel plateCharecterFromJson(String str) =>
    PlateCharecterModel.fromJson(json.decode(str));

String plateCharecterToJson(PlateCharecterModel data) =>
    json.encode(data.toJson());

class PlateCharecterModel {
  String name;
  String governorateId;
  String governorateName;
  String id;
  DateTime creationDate;
  bool deleted;

  PlateCharecterModel({
    required this.name,
    required this.governorateId,
    required this.governorateName,
    required this.id,
    required this.creationDate,
    required this.deleted,
  });

  factory PlateCharecterModel.fromJson(Map<String, dynamic> json) =>
      PlateCharecterModel(
        name: json["name"],
        governorateId: json["governorateId"],
        governorateName: json["governorateName"],
        id: json["id"],
        creationDate: DateTime.parse(json["creationDate"]),
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "governorateId": governorateId,
        "governorateName": governorateName,
        "id": id,
        "creationDate": creationDate.toIso8601String(),
        "deleted": deleted,
      };
}
