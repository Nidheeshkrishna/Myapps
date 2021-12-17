// To parse this JSON data, do
//
//     final hotspotModel = hotspotModelFromMap(jsonString);

import 'dart:convert';

class HotspotModel {
  HotspotModel({
    this.result,
    this.allresult,
    this.apiKeyStatus,
  });

  List<Result> result;
  List<Result> allresult;
  bool apiKeyStatus;

  factory HotspotModel.fromJson(String str) =>
      HotspotModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotspotModel.fromMap(Map<String, dynamic> json) => HotspotModel(
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
        allresult:
            List<Result>.from(json["allresult"].map((x) => Result.fromMap(x))),
        apiKeyStatus: json["ApiKey_status"],
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
        "allresult": List<dynamic>.from(allresult.map((x) => x.toMap())),
        "ApiKey_status": apiKeyStatus,
      };
}

class Result {
  Result({
    this.hotspotId,
    this.businessId,
    this.businessName,
    this.businessAddress,
    this.expiryDate,
    this.openingTime,
    this.closingTime,
    this.status,
    this.coverImageUrl,
  });

  int hotspotId;
  int businessId;
  String businessName;
  String businessAddress;
  String expiryDate;
  String openingTime;
  String closingTime;
  String status;
  String coverImageUrl;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        hotspotId: json["HotspotID"],
        businessId: json["BusinessID"],
        businessName: json["BusinessName"],
        businessAddress:
            json["BusinessAddress"] == null ? null : json["BusinessAddress"],
        expiryDate: json["ExpiryDate"],
        openingTime: json["OpeningTime"],
        closingTime: json["ClosingTime"],
        status: json["Status"],
        coverImageUrl: json["CoverImageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "HotspotID": hotspotId,
        "BusinessID": businessId,
        "BusinessName": businessName,
        "BusinessAddress": businessAddress == null ? null : businessAddress,
        "ExpiryDate": expiryDate,
        "OpeningTime": openingTime,
        "ClosingTime": closingTime,
        "Status": status,
        "CoverImageUrl": coverImageUrl,
      };
}
