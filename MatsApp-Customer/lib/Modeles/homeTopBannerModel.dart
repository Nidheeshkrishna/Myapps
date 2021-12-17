// To parse this JSON data, do
//
//     final topBannerModel = topBannerModelFromMap(jsonString);

import 'dart:convert';

class TopBannerModel {
  TopBannerModel({
    this.result,
    this.apiKeyStatus,
  });

  List<Result> result;
  bool apiKeyStatus;

  factory TopBannerModel.fromJson(String str) =>
      TopBannerModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TopBannerModel.fromMap(Map<String, dynamic> json) => TopBannerModel(
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
        apiKeyStatus: json["ApiKey_status"],
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
        "ApiKey_status": apiKeyStatus,
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.imageUrl,
    this.priority,
    this.redirectionPage,
    this.redirectionUrl,
    this.redirectionId,
    this.businessName,
  });

  int id;
  String name;
  String imageUrl;
  String priority;
  String redirectionPage;
  String redirectionUrl;
  int redirectionId;
  String businessName;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["ID"],
        name: json["Name"],
        imageUrl: json["ImageURL"],
        priority: json["Priority"],
        redirectionPage: json["redirectionPage"],
        redirectionUrl: json["redirectionURL"],
        redirectionId: json["redirectionID"],
        businessName: json["BusinessName"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "Name": name,
        "ImageURL": imageUrl,
        "Priority": priority,
        "redirectionPage": redirectionPage,
        "redirectionURL": redirectionUrl,
        "BusinessName": businessName,
      };
}
