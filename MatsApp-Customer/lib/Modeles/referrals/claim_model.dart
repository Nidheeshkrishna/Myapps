// To parse this JSON data, do
//
//     final claimModel = claimModelFromMap(jsonString);

import 'dart:convert';

class ClaimModel {
  ClaimModel({
    this.result,
  });

  bool result;

  factory ClaimModel.fromJson(String str) =>
      ClaimModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClaimModel.fromMap(Map<String, dynamic> json) => ClaimModel(
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
      };
}
