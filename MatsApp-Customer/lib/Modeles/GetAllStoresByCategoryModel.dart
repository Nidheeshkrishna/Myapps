// To parse this JSON data, do
//
//     final getAllStoresByCategoryModel = getAllStoresByCategoryModelFromMap(jsonString);

import 'dart:convert';

class GetAllStoresByCategoryModel {
  GetAllStoresByCategoryModel({
    this.result,
    this.apiKeyStatus,
  });

  List<Result> result;
  bool apiKeyStatus;

  factory GetAllStoresByCategoryModel.fromJson(String str) =>
      GetAllStoresByCategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllStoresByCategoryModel.fromMap(Map<String, dynamic> json) =>
      GetAllStoresByCategoryModel(
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
    this.pkBusinessId,
    this.businessName,
    this.coverImageUrl,
    this.provideOffers,
    this.isMall,
    this.rating,
    this.wishListId,
    this.distanceinKm,
    this.town,
  });

  int pkBusinessId;
  String businessName;
  String coverImageUrl;
  String provideOffers;
  bool isMall;
  int rating;
  int wishListId;
  String distanceinKm;
  String town;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        pkBusinessId: json["PK_BusinessID"],
        businessName: json["BusinessName"],
        coverImageUrl: json["CoverImageUrl"],
        provideOffers: json["ProvideOffers"],
        isMall: json["IsMall"],
        rating: json["Rating"],
        wishListId: json["WishListID"],
        distanceinKm: json["DistanceinKm"],
        town: json["Town"],
      );

  Map<String, dynamic> toMap() => {
        "PK_BusinessID": pkBusinessId,
        "BusinessName": businessName,
        "CoverImageUrl": coverImageUrl,
        "ProvideOffers": provideOffers,
        "IsMall": isMall,
        "Rating": rating,
        "WishListID": wishListId,
        "DistanceinKm": distanceinKm,
        "Town": town,
      };
}
