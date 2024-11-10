// To parse this JSON data, do
//
//     final governurateModel = governurateModelFromJson(jsonString);

import 'dart:convert';

GovernurateModel governurateModelFromJson(String str) => GovernurateModel.fromJson(json.decode(str));

String governurateModelToJson(GovernurateModel data) => json.encode(data.toJson());

class GovernurateModel {
    String name;
    String id;
    DateTime creationDate;
    bool deleted;

    GovernurateModel({
        required this.name,
        required this.id,
        required this.creationDate,
        required this.deleted,
    });

    factory GovernurateModel.fromJson(Map<String, dynamic> json) => GovernurateModel(
        name: json["name"],
        id: json["id"],
        creationDate: DateTime.parse(json["creationDate"]),
        deleted: json["deleted"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "creationDate": creationDate.toIso8601String(),
        "deleted": deleted,
    };
}
