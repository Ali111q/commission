import 'dart:convert';

Statics staticsFromJson(String str) => Statics.fromJson(json.decode(str));

String staticsToJson(Statics data) => json.encode(data.toJson());

class Statics {
  List<ViolationCardAnalysis> violationCardAnalysis;
  int numberOfViolations;
  int totalPrice;
  List<LastViolation> lastViolations;

  Statics({
    required this.violationCardAnalysis,
    required this.numberOfViolations,
    required this.totalPrice,
    required this.lastViolations,
  });

  factory Statics.fromJson(Map<String, dynamic> json) => Statics(
        violationCardAnalysis: List<ViolationCardAnalysis>.from(
            json["violationCardAnalysis"]
                .map((x) => ViolationCardAnalysis.fromJson(x))),
        numberOfViolations: json["numberOfViolations"],
        totalPrice: json["totalPrice"],
        lastViolations: List<LastViolation>.from(
            json["lastViolations"].map((x) => LastViolation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "violationCardAnalysis":
            List<dynamic>.from(violationCardAnalysis.map((x) => x.toJson())),
        "numberOfViolations": numberOfViolations,
        "totalPrice": totalPrice,
        "lastViolations":
            List<dynamic>.from(lastViolations.map((x) => x.toJson())),
      };
}

class LastViolation {
  int number;
  String userId;
  String userFullName;
  String userGarageId;
  dynamic userGarageName;
  dynamic garageGovernorateName;
  String vehicleId;
  String vehicleChassisNumber;
  String? vehiclePlateCharacterId;
  String? vehiclePlateCharacterName;
  dynamic vehiclePlateType;
  String vehicleGovernorateId;
  dynamic vehicleGovernorateName;
  String plateNumber;
  FeeFines feeFines;
  bool isPaid;
  List<dynamic> images;
  int duplicateCount;
  int amount;
  int totalAmount;
  dynamic lat;
  dynamic lng;
  int invoiceNumber;
  String garageId;
  dynamic garageName;
  dynamic paymentGarageId;
  dynamic paymentGarage;
  dynamic paymentReceiptNumber;
  dynamic paymentDate;
  int status;
  String note;
  bool isDirect;
  String id;
  DateTime creationDate;
  bool deleted;

  LastViolation({
    required this.number,
    required this.userId,
    required this.userFullName,
    required this.userGarageId,
    required this.userGarageName,
    required this.garageGovernorateName,
    required this.vehicleId,
    required this.vehicleChassisNumber,
    required this.vehiclePlateCharacterId,
    required this.vehiclePlateCharacterName,
    required this.vehiclePlateType,
    required this.vehicleGovernorateId,
    required this.vehicleGovernorateName,
    required this.plateNumber,
    required this.feeFines,
    required this.isPaid,
    required this.images,
    required this.duplicateCount,
    required this.amount,
    required this.totalAmount,
    required this.lat,
    required this.lng,
    required this.invoiceNumber,
    required this.garageId,
    required this.garageName,
    required this.paymentGarageId,
    required this.paymentGarage,
    required this.paymentReceiptNumber,
    required this.paymentDate,
    required this.status,
    required this.note,
    required this.isDirect,
    required this.id,
    required this.creationDate,
    required this.deleted,
  });

  factory LastViolation.fromJson(Map<String, dynamic> json) => LastViolation(
        number: json["number"],
        userId: json["userId"],
        userFullName: json["userFullName"],
        userGarageId: json["userGarageId"],
        userGarageName: json["userGarageName"],
        garageGovernorateName: json["garageGovernorateName"],
        vehicleId: json["vehicleId"],
        vehicleChassisNumber: json["vehicleChassisNumber"] ?? "",
        vehiclePlateCharacterId: json["vehiclePlateCharacterId"],
        vehiclePlateCharacterName: json["vehiclePlateCharacterName"],
        vehiclePlateType: json["vehiclePlateType"],
        vehicleGovernorateId: json["vehicleGovernorateId"],
        vehicleGovernorateName: json["vehicleGovernorateName"],
        plateNumber: json["plateNumber"],
        feeFines: FeeFines.fromJson(json["feeFines"]),
        isPaid: json["isPaid"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        duplicateCount: json["duplicateCount"],
        amount: json["amount"],
        totalAmount: json["totalAmount"],
        lat: json["lat"],
        lng: json["lng"],
        invoiceNumber: json["invoiceNumber"],
        garageId: json["garageId"],
        garageName: json["garageName"],
        paymentGarageId: json["paymentGarageId"],
        paymentGarage: json["paymentGarage"],
        paymentReceiptNumber: json["paymentReceiptNumber"],
        paymentDate: json["paymentDate"],
        status: json["status"],
        note: json["note"] ?? "",
        isDirect: json["isDirect"],
        id: json["id"],
        creationDate: DateTime.parse(json["creationDate"]),
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "userId": userId,
        "userFullName": userFullName,
        "userGarageId": userGarageId,
        "userGarageName": userGarageName,
        "garageGovernorateName": garageGovernorateName,
        "vehicleId": vehicleId,
        "vehicleChassisNumber": vehicleChassisNumber,
        "vehiclePlateCharacterId": vehiclePlateCharacterId,
        "vehiclePlateCharacterName": vehiclePlateCharacterName,
        "vehiclePlateType": vehiclePlateType,
        "vehicleGovernorateId": vehicleGovernorateId,
        "vehicleGovernorateName": vehicleGovernorateName,
        "plateNumber": plateNumber,
        "feeFines": feeFines.toJson(),
        "isPaid": isPaid,
        "images": List<dynamic>.from(images.map((x) => x)),
        "duplicateCount": duplicateCount,
        "amount": amount,
        "totalAmount": totalAmount,
        "lat": lat,
        "lng": lng,
        "invoiceNumber": invoiceNumber,
        "garageId": garageId,
        "garageName": garageName,
        "paymentGarageId": paymentGarageId,
        "paymentGarage": paymentGarage,
        "paymentReceiptNumber": paymentReceiptNumber,
        "paymentDate": paymentDate,
        "status": status,
        "note": note,
        "isDirect": isDirect,
        "id": id,
        "creationDate": creationDate.toIso8601String(),
        "deleted": deleted,
      };
}

class FeeFines {
  String name;
  int amount;
  dynamic type;
  String id;
  DateTime creationDate;
  bool deleted;

  FeeFines({
    required this.name,
    required this.amount,
    required this.type,
    required this.id,
    required this.creationDate,
    required this.deleted,
  });

  factory FeeFines.fromJson(Map<String, dynamic> json) => FeeFines(
        name: json["name"],
        amount: json["amount"],
        type: json["type"],
        id: json["id"],
        creationDate: DateTime.parse(json["creationDate"]),
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "type": type,
        "id": id,
        "creationDate": creationDate.toIso8601String(),
        "deleted": deleted,
      };
}

class ViolationCardAnalysis {
  String name;
  int amount;

  ViolationCardAnalysis({
    required this.name,
    required this.amount,
  });

  factory ViolationCardAnalysis.fromJson(Map<String, dynamic> json) =>
      ViolationCardAnalysis(
        name: json["name"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
      };
}
