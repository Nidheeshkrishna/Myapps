// To parse this JSON data, do
//
//     final setnewForgotPasswordModel = setnewForgotPasswordModelFromMap(jsonString);

import 'dart:convert';

class SetnewForgotPasswordModel {
  SetnewForgotPasswordModel({
    this.result,
  });

  int result;

  factory SetnewForgotPasswordModel.fromJson(String str) =>
      SetnewForgotPasswordModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SetnewForgotPasswordModel.fromMap(Map<String, dynamic> json) =>
      SetnewForgotPasswordModel(
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
      };
}
