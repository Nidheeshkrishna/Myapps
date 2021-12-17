// To parse this JSON data, do
//
//     final shareCouponModel = shareCouponModelFromMap(jsonString);

import 'dart:convert';

class ShareCouponModel {
  ShareCouponModel({
    this.result,
    this.apiKeyStatus,
  });

  int result;
  bool apiKeyStatus;

  factory ShareCouponModel.fromJson(String str) =>
      ShareCouponModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShareCouponModel.fromMap(Map<String, dynamic> json) =>
      ShareCouponModel(
        result: json["result"],
        apiKeyStatus: json["ApiKey_status"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "ApiKey_status": apiKeyStatus,
      };
}
