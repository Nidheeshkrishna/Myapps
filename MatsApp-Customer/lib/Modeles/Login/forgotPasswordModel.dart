// To parse this JSON data, do
//
//     final forgotPasswordModel = forgotPasswordModelFromMap(jsonString);

import 'dart:convert';

class ForgotPasswordModel {
  ForgotPasswordModel({
    this.result,
    this.otp,
  });

  int result;
  String otp;

  factory ForgotPasswordModel.fromJson(String str) =>
      ForgotPasswordModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ForgotPasswordModel.fromMap(Map<String, dynamic> json) =>
      ForgotPasswordModel(
        result: json["result"],
        otp: json["otp"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "otp": otp,
      };
}
