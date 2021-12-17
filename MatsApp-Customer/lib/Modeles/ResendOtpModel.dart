// To parse this JSON data, do
//
//     final resendOtpModel = resendOtpModelFromMap(jsonString);

import 'dart:convert';

class ResendOtpModel {
  ResendOtpModel({
    this.result,
    this.status,
  });

  Result result;
  int status;

  factory ResendOtpModel.fromJson(String str) =>
      ResendOtpModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResendOtpModel.fromMap(Map<String, dynamic> json) => ResendOtpModel(
        result: Result.fromMap(json["result"]),
        status: json["Status"],
      );

  Map<String, dynamic> toMap() => {
        "result": result.toMap(),
        "Status": status,
      };
}

class Result {
  Result({
    this.userId,
    this.userMobile,
    this.userReferralCode,
    this.status,
    this.userOtp,
    this.userPassword,
    this.queryString,
  });

  int userId;
  String userMobile;
  String userReferralCode;
  int status;
  String userOtp;
  String userPassword;
  String queryString;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        userId: json["User_ID"],
        userMobile: json["User_Mobile"],
        userReferralCode: json["User_ReferralCode"],
        status: json["Status"],
        userOtp: json["User_OTP"],
        userPassword: json["User_Password"],
        queryString: json["QueryString"],
      );

  Map<String, dynamic> toMap() => {
        "User_ID": userId,
        "User_Mobile": userMobile,
        "User_ReferralCode": userReferralCode,
        "Status": status,
        "User_OTP": userOtp,
        "User_Password": userPassword,
        "QueryString": queryString,
      };
}
