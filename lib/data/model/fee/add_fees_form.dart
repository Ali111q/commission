// To parse this JSON data, do
//
//     final addFeesForm = addFeesFormFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddFeesFormModel addFeesFormFromJson(String str) =>
    AddFeesFormModel.fromJson(json.decode(str));

String addFeesFormToJson(AddFeesFormModel data) => json.encode(data.toJson());

class AddFeesFormModel {
  int number;
  String plateNumber;
  String? plateCharacterId;
  String plateTypeId;
  String feeFinesId;
  String garageId;

  String governorateId;
  List images;
  String? note;
  String lat;
  String lng;
  String violationLocation;

  AddFeesFormModel({
    required this.number,
    required this.plateNumber,
    this.plateCharacterId,
    required this.plateTypeId,
    required this.feeFinesId,
    required this.garageId,
    required this.governorateId,
    required this.images,
    this.note,
    required this.lat,
    required this.lng,
    required this.violationLocation,
  });

  factory AddFeesFormModel.fromJson(Map<String, dynamic> json) =>
      AddFeesFormModel(
        number: json["number"],
        plateNumber: json["plateNumber"],
        plateCharacterId: json["plateCharacterId"],
        plateTypeId: json["plateTypeId"],
        feeFinesId: json["feeFinesId"],
        garageId: json["garageId"],
        governorateId: json["governorateId"],
        images: List<String>.from(json["images"].map((x) => x)),
        note: json["note"],
        lat: json["lat"],
        lng: json["lng"],
        violationLocation: json["violationLocation"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "plateNumber": plateNumber,
        "plateCharacterId": plateCharacterId,
        "plateTypeId": plateTypeId,
        "feeFinesId": feeFinesId,
        "garageId": garageId,
        "governorateId": governorateId,
        "images": List<dynamic>.from(images.map((x) => x)),
        "note": note,
        "lat": lat,
        "lng": lng,
      };
}
