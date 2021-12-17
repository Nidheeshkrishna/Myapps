// To parse this JSON data, do
//
//     final allcategoryModel = allcategoryModelFromMap(jsonString);

import 'dart:convert';

class AllcategoryModel {
  AllcategoryModel({
    this.result,
    this.apiKeyStatus,
  });

  List<Result> result;
  bool apiKeyStatus;

  factory AllcategoryModel.fromJson(String str) =>
      AllcategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllcategoryModel.fromMap(Map<String, dynamic> json) =>
      AllcategoryModel(
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
    this.categoryName,
    this.categoryImage,
    this.categoryFind,
    this.categoryPartnerLogo,
  });

  int id;
  String categoryName;
  String categoryImage;
  String categoryFind;
  String categoryPartnerLogo;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["Id"],
        categoryName: json["CategoryName"],
        categoryImage: json["CategoryImage"],
        categoryFind: json["CategoryFind"],
        categoryPartnerLogo: json["CategoryPartnerLogo"],
      );

  Map<String, dynamic> toMap() => {
        "Id": id,
        "CategoryName": categoryName,
        "CategoryImage": categoryImage,
        "CategoryFind": categoryFind,
        "CategoryPartnerLogo": categoryPartnerLogo,
      };
}
