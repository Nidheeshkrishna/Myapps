// To parse this JSON data, do
//
//     final greetingsModel = greetingsModelFromMap(jsonString);

import 'dart:convert';

GreetingsModel greetingsModelFromMap(String str) =>
    GreetingsModel.fromMap(json.decode(str));

String greetingsModelToMap(GreetingsModel data) => json.encode(data.toMap());

class GreetingsModel {
  GreetingsModel({
    this.result,
    this.apiKeyStatus,
  });

  Result result;
  bool apiKeyStatus;

  factory GreetingsModel.fromMap(Map<String, dynamic> json) => GreetingsModel(
        result: json["result"] == null ? null : Result.fromMap(json["result"]),
        apiKeyStatus:
            json["ApiKey_status"] == null ? null : json["ApiKey_status"],
      );

  Map<String, dynamic> toMap() => {
        "result": result == null ? null : result.toMap(),
        "ApiKey_status": apiKeyStatus == null ? null : apiKeyStatus,
      };
}

class Result {
  Result({
    this.grNotifId,
    this.greetingImage,
    this.greetingDate,
  });

  int grNotifId;
  String greetingImage;
  String greetingDate;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        grNotifId: json["GRNotif_ID"] == null ? null : json["GRNotif_ID"],
        greetingImage:
            json["GreetingImage"] == null ? null : json["GreetingImage"],
        greetingDate:
            json["GreetingDate"] == null ? null : json["GreetingDate"],
      );

  Map<String, dynamic> toMap() => {
        "GRNotif_ID": grNotifId == null ? null : grNotifId,
        "GreetingImage": greetingImage == null ? null : greetingImage,
        "GreetingDate": greetingDate == null ? null : greetingDate,
      };
}
