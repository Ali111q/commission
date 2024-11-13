// To parse this JSON data, do
//
//     final feeModel = feeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FeeModel feeModelFromJson(String str) => FeeModel.fromJson(json.decode(str));

String feeModelToJson(FeeModel data) => json.encode(data.toJson());

class FeeModel {
  String id;
  DateTime creationDate;

  int number;
  String? plateNumber;
  String? governorateId;
  String? governorateName;
  String? plateCharacterId;
  String? plateCharacterName;
  String? plateTypeId;
  String? plateTypeName;
  String? feeFinesId;
  String? feeFinesName;
  String? garageId;
  String? garageName;
  int amount;
  bool isPaid;
  String? paymentNumber;
  DateTime? paymentDate;
  String? garagePaymentId;
  String? garagePaymentName;
  String? invoiceNumber;
  bool isDirect;
  List images;
  String? note;
  String? lat;
  String? lng;
  String? violationLocation;

  FeeModel({
    required this.id,
    required this.creationDate,
    required this.number,
    required this.plateNumber,
    required this.governorateId,
    required this.governorateName,
    required this.plateCharacterId,
    required this.plateCharacterName,
    required this.plateTypeId,
    required this.plateTypeName,
    required this.feeFinesId,
    required this.feeFinesName,
    required this.garageId,
    required this.garageName,
    required this.amount,
    required this.isPaid,
    required this.paymentNumber,
    required this.paymentDate,
    required this.garagePaymentId,
    required this.garagePaymentName,
    required this.invoiceNumber,
    required this.isDirect,
    required this.images,
    required this.note,
    required this.lat,
    required this.lng,
    required this.violationLocation,
  });

  factory FeeModel.fromJson(Map<String, dynamic> json) => FeeModel(
        id: json["id"],
        creationDate: DateTime.parse(json["creationDate"]),
        number: json["number"],
        plateNumber: json["plateNumber"],
        governorateId: json["governorateId"],
        governorateName:
            json["garageGovernorateName"] ?? json['governorateName'],
        plateCharacterId: json["plateCharacterId"],
        plateCharacterName:
            json["vehiclePlateCharacterName"] ?? json['plateCharacterName'],
        plateTypeId: json["plateTypeId"],
        plateTypeName: json["vehiclePlateType"] ?? json['plateTypeName'],
        feeFinesId: json["feeFinesId"],
        feeFinesName: json['feeFines'] != null ? json["feeFines"]["name"] : "",
        garageId: json["garageId"],
        garageName: json["garageName"],
        amount: json["amount"],
        isPaid: json["isPaid"],
        paymentNumber: json["paymentNumber"],
        paymentDate: json["paymentDate"] == null
            ? null
            : DateTime.parse(json["paymentDate"]),
        garagePaymentId: json["garagePaymentId"],
        garagePaymentName: json["garagePaymentName"],
        invoiceNumber: json["invoiceNumber"].toString(),
        isDirect: json["isDirect"] ?? true,
        images: List<String>.from(json["images"]
                ?.map((x) => "https://garages-api.future-wave.co/" + x) ??
            []),
        note: json["note"],
        lat: json["lat"],
        lng: json["lng"],
        violationLocation: json["violationLocation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "creationDate": creationDate.toIso8601String(),
        "number": number,
        "plateNumber": plateNumber,
        "governorateId": governorateId,
        "governorateName": governorateName,
        "plateCharacterId": plateCharacterId,
        "plateCharacterName": plateCharacterName,
        "plateTypeId": plateTypeId,
        "plateTypeName": plateTypeName,
        "feeFinesId": feeFinesId,
        "feeFinesName": feeFinesName,
        "garageId": garageId,
        "garageName": garageName,
        "amount": amount,
        "isPaid": isPaid,
        "paymentNumber": paymentNumber,
        "paymentDate": paymentDate?.toIso8601String(),
        "garagePaymentId": garagePaymentId,
        "garagePaymentName": garagePaymentName,
        "invoiceNumber": invoiceNumber,
        "isDirect": isDirect,
        "images": List<dynamic>.from(images.map((x) => x)),
        "note": note,
        "lat": lat,
        "lng": lng,
        "violationLocation": violationLocation,
      };
}
