// To parse this JSON data, do
//
//     final feeTypeModel = feeTypeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FeeTypeModel feeTypeModelFromJson(String str) =>
    FeeTypeModel.fromJson(json.decode(str));

String feeTypeModelToJson(FeeTypeModel data) => json.encode(data.toJson());

class FeeTypeModel {
  String id;
  DateTime creationDate;
  bool deleted;
  String name;
  int? amount;
  int? type;

  FeeTypeModel({
    required this.id,
    required this.creationDate,
    required this.deleted,
    required this.name,
    this.amount,
    this.type,
  });

  factory FeeTypeModel.fromJson(Map<String, dynamic> json) => FeeTypeModel(
        id: json["id"],
        creationDate: DateTime.parse(json["creationDate"]),
        deleted: json["deleted"],
        name: json["name"],
        amount: json["amount"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "creationDate": creationDate.toIso8601String(),
        "deleted": deleted,
        "name": name,
        "amount": amount,
        "type": type,
      };
}
