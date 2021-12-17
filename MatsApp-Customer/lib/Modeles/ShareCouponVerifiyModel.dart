// To parse this JSON data, do
//
//     final shareCouponVerifiyModel = shareCouponVerifiyModelFromMap(jsonString);

import 'dart:convert';

class ShareCouponVerifiyModel {
  ShareCouponVerifiyModel({
    this.result,
    this.apiKeyStatus,
  });

  Result result;
  bool apiKeyStatus;

  factory ShareCouponVerifiyModel.fromJson(String str) =>
      ShareCouponVerifiyModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShareCouponVerifiyModel.fromMap(Map<String, dynamic> json) =>
      ShareCouponVerifiyModel(
        result: Result.fromMap(json["result"]),
        apiKeyStatus: json["ApiKey_status"],
      );

  Map<String, dynamic> toMap() => {
        "result": result.toMap(),
        "ApiKey_status": apiKeyStatus,
      };
}

class Result {
  Result({
    this.userId,
    this.username,
    this.photoUrl,
    this.mobile,
    this.location,
  });

  int userId;
  String username;
  String photoUrl;
  String mobile;
  String location;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        userId: json["UserID"],
        username: json["Username"],
        photoUrl: json["Photo_URL"],
        mobile: json["mobile"],
        location: json["Location"],
      );

  Map<String, dynamic> toMap() => {
        "UserID": userId,
        "Username": username,
        "Photo_URL": photoUrl,
        "mobile": mobile,
        "Location": location,
      };
}
