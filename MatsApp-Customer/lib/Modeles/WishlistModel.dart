// To parse this JSON data, do
//
//     final wishlistModel = wishlistModelFromMap(jsonString);

import 'dart:convert';

class WishlistModel {
  WishlistModel({
    this.result,
  });

  List<Result> result;

  factory WishlistModel.fromJson(String str) =>
      WishlistModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WishlistModel.fromMap(Map<String, dynamic> json) => WishlistModel(
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.id,
    this.categoryId,
    this.category,
    this.businessId,
    this.businessName,
    this.productName,
    this.rating,
    this.location,
    this.imageUrl,
    this.distanceinKm,
    this.provideOffers,
  });

  int id;
  int categoryId;
  String category;
  int businessId;
  String businessName;
  dynamic productName;
  int rating;
  String location;
  String imageUrl;
  String distanceinKm;
  String provideOffers;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["Id"],
        categoryId: json["CategoryID"],
        category: json["Category"],
        businessId: json["BusinessID"],
        businessName: json["BusinessName"],
        productName: json["ProductName"],
        rating: json["Rating"],
        location: json["Location"],
        imageUrl: json["ImageUrl"],
        distanceinKm: json["DistanceinKm"],
        provideOffers: json["ProvideOffers"],
      );

  Map<String, dynamic> toMap() => {
        "Id": id,
        "CategoryID": categoryId,
        "Category": category,
        "BusinessID": businessId,
        "BusinessName": businessName,
        "ProductName": productName,
        "Rating": rating,
        "Location": location,
        "ImageUrl": imageUrl,
        "DistanceinKm": distanceinKm,
        "ProvideOffers": provideOffers,
      };
}
