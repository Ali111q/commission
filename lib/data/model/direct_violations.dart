class DirectViolation {
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
  bool? isPaid;
  dynamic paymentNumber;
  dynamic paymentDate;
  dynamic garagePaymentId;
  dynamic garagePaymentName;
  String invoiceNumber;
  dynamic isDirect;
  List<dynamic> images;
  dynamic note;
  dynamic lat;
  dynamic lng;
  dynamic violationLocation;
  String id;
  DateTime creationDate;

  DirectViolation({
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
    required this.id,
    required this.creationDate,
  });

  factory DirectViolation.fromJson(Map<String, dynamic> json) =>
      DirectViolation(
        number: json["number"],
        plateNumber: json["plateNumber"],
        governorateId: json["governorateId"],
        governorateName: json["governorateName"],
        plateCharacterId: json["plateCharacterId"],
        plateCharacterName: json["plateCharacterName"],
        plateTypeId: json["plateTypeId"],
        plateTypeName: json["plateTypeName"],
        feeFinesId: json["feeFinesId"],
        feeFinesName: json["feeFinesName"],
        garageId: json["garageId"],
        garageName: json["garageName"],
        amount: json["amount"],
        isPaid: json["isPaid"],
        paymentNumber: json["paymentNumber"],
        paymentDate: json["paymentDate"],
        garagePaymentId: json["garagePaymentId"],
        garagePaymentName: json["garagePaymentName"],
        invoiceNumber: json["invoiceNumber"],
        isDirect: json["isDirect"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        note: json["note"],
        lat: json["lat"],
        lng: json["lng"],
        violationLocation: json["violationLocation"],
        id: json["id"],
        creationDate: DateTime.parse(json["creationDate"]),
      );

  Map<String, dynamic> toJson() => {
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
        "paymentDate": paymentDate,
        "garagePaymentId": garagePaymentId,
        "garagePaymentName": garagePaymentName,
        "invoiceNumber": invoiceNumber,
        "isDirect": isDirect,
        "images": List<dynamic>.from(images.map((x) => x)),
        "note": note,
        "lat": lat,
        "lng": lng,
        "violationLocation": violationLocation,
        "id": id,
        "creationDate": creationDate.toIso8601String(),
      };
}
