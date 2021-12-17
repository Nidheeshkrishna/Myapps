// To parse this JSON data, do
//
//     final loginExistCheckModel = loginExistCheckModelFromMap(jsonString);

import 'dart:convert';

class LoginExistCheckModel {
  LoginExistCheckModel({
    this.result,
  });

  String result;

  factory LoginExistCheckModel.fromJson(String str) =>
      LoginExistCheckModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginExistCheckModel.fromMap(Map<String, dynamic> json) =>
      LoginExistCheckModel(
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
      };
}
