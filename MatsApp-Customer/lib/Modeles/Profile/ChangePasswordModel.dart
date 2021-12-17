// To parse this JSON data, do
//
//     final changePasswordModel = changePasswordModelFromMap(jsonString);

import 'dart:convert';

class ChangePasswordModel {
  ChangePasswordModel({
    this.result,
  });

  int result;

  factory ChangePasswordModel.fromJson(String str) =>
      ChangePasswordModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChangePasswordModel.fromMap(Map<String, dynamic> json) =>
      ChangePasswordModel(
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
      };
}
