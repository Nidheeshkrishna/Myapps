// To parse this JSON data, do
//
//     final SubscriptionDetailsModel = SubscriptionDetailsModelFromMap(jsonString);

import 'dart:convert';

class SubscriptionDetailsModel {
  SubscriptionDetailsModel({
    this.result,
  });

  Result result;

  factory SubscriptionDetailsModel.fromJson(String str) =>
      SubscriptionDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubscriptionDetailsModel.fromMap(Map<String, dynamic> json) =>
      SubscriptionDetailsModel(
        result: Result.fromMap(json["result"]),
      );

  Map<String, dynamic> toMap() => {
        "result": result.toMap(),
      };
}

class Result {
  Result({
    this.pkgId,
    this.pkgDescription,
    this.pkgPeriod,
    this.pkgAmount,
    this.pkgPremiumFlag,
    this.endDate,
    this.endTime,
  });

  int pkgId;
  String pkgDescription;
  String pkgPeriod;
  double pkgAmount;
  String pkgPremiumFlag;
  String endDate;
  String endTime;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        pkgId: json["PKG_ID"],
        pkgDescription: json["PKG_Description"],
        pkgPeriod: json["PKG_Period"],
        pkgAmount: json["PKG_Amount"],
        pkgPremiumFlag: json["PKG_PremiumFlag"],
        endDate: json["EndDate"],
        endTime: json["EndTime"],
      );

  Map<String, dynamic> toMap() => {
        "PKG_ID": pkgId,
        "PKG_Description": pkgDescription,
        "PKG_Period": pkgPeriod,
        "PKG_Amount": pkgAmount,
        "PKG_PremiumFlag": pkgPremiumFlag,
        "EndDate": endDate,
        "EndTime": endTime,
      };
}
