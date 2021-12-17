// To parse this JSON data, do
//
//     final changeLocationModel = changeLocationModelFromMap(jsonString);

import 'dart:convert';

class ChangeLocationModel {
  ChangeLocationModel({
    this.result,
    this.apiKeyStatus,
  });

  int result;
  bool apiKeyStatus;

  factory ChangeLocationModel.fromJson(String str) =>
      ChangeLocationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChangeLocationModel.fromMap(Map<String, dynamic> json) =>
      ChangeLocationModel(
        result: json["result"],
        apiKeyStatus: json["ApiKey_status"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "ApiKey_status": apiKeyStatus,
      };
}
