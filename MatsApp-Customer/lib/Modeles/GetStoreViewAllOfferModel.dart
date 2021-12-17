// To parse this JSON data, do
//
//     final getStoreViewAllOfferModel = getStoreViewAllOfferModelFromMap(jsonString);

import 'dart:convert';

class GetStoreViewAllOfferModel {
  GetStoreViewAllOfferModel({
    this.result,
  });

  List<Result> result;

  factory GetStoreViewAllOfferModel.fromJson(String str) =>
      GetStoreViewAllOfferModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetStoreViewAllOfferModel.fromMap(Map<String, dynamic> json) =>
      GetStoreViewAllOfferModel(
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.couponId,
    this.couponTitle,
    this.discount,
    this.productId,
    this.productName,
    this.businessId,
    this.businessName,
    this.productImage,
    this.productPrice,
    this.couponValue,
    this.rating,
  });

  String couponId;
  String couponTitle;
  int discount;
  int productId;
  String productName;
  dynamic businessId;
  dynamic businessName;
  String productImage;
  int productPrice;
  dynamic couponValue;
  int rating;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        couponId: json["CouponID"],
        couponTitle: json["CouponTitle"],
        discount: json["Discount"],
        productId: json["ProductID"],
        productName: json["ProductName"],
        businessId: json["BusinessID"],
        businessName: json["BusinessName"],
        productImage: json["ProductImage"],
        productPrice: json["ProductPrice"],
        couponValue: json["CouponValue"],
        rating: json["Rating"],
      );

  Map<String, dynamic> toMap() => {
        "CouponID": couponId,
        "CouponTitle": couponTitle,
        "Discount": discount,
        "ProductID": productId,
        "ProductName": productName,
        "BusinessID": businessId,
        "BusinessName": businessName,
        "ProductImage": productImage,
        "ProductPrice": productPrice,
        "CouponValue": couponValue,
        "Rating": rating,
      };
}
