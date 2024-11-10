// To parse this JSON data, do
//
//     final plateCarTypeModel = plateCarTypeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PlateCarTypeModel plateCarTypeModelFromJson(String str) =>
    PlateCarTypeModel.fromJson(json.decode(str));

String plateCarTypeModelToJson(PlateCarTypeModel data) =>
    json.encode(data.toJson());

class PlateCarTypeModel {
  String name;
  String id;
  dynamic creationDate;
  bool deleted;

  PlateCarTypeModel({
    required this.name,
    required this.id,
    required this.creationDate,
    required this.deleted,
  });

  factory PlateCarTypeModel.fromJson(Map<String, dynamic> json) =>
      PlateCarTypeModel(
        name: json["name"],
        id: json["id"],
        creationDate: json["creationDate"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "creationDate": creationDate,
        "deleted": deleted,
      };
}
