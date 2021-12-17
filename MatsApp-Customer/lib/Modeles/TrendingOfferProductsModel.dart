// To parse this JSON data, do
//
//     final trendingOfferProductsModel = trendingOfferProductsModelFromMap(jsonString);

import 'dart:convert';

class TrendingOfferProductsModel {
  TrendingOfferProductsModel({
    this.result,
  });

  Result result;

  factory TrendingOfferProductsModel.fromJson(String str) =>
      TrendingOfferProductsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrendingOfferProductsModel.fromMap(Map<String, dynamic> json) =>
      TrendingOfferProductsModel(
        result: Result.fromMap(json["result"]),
      );

  Map<String, dynamic> toMap() => {
        "result": result.toMap(),
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.businessId,
    this.businessName,
    this.price,
    this.offerPrice,
    this.shopPrice,
    this.description,
    this.specification,
    this.couponId,
    this.couponTitle,
    this.discount,
    this.couponValue,
    this.expiryDate,
    this.productImage,
    this.rating,
    this.couponDetails,
    this.couponType,
    this.couponLeft,
    this.purchaseAmount,
    this.saveAmount,
    this.couponAvailableFlag,
  });

  int id;
  String name;
  int businessId;
  String businessName;
  String price;
  String offerPrice;
  dynamic shopPrice;
  String description;
  String specification;
  String couponId;
  dynamic couponTitle;
  dynamic discount;
  dynamic couponValue;
  String expiryDate;
  String productImage;
  int rating;
  dynamic couponDetails;
  String couponType;
  dynamic couponLeft;
  String purchaseAmount;
  String saveAmount;
  String couponAvailableFlag;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["ID"],
        name: json["Name"],
        businessId: json["BusinessID"],
        businessName: json["BusinessName"],
        price: json["Price"],
        offerPrice: json["OfferPrice"],
        shopPrice: json["ShopPrice"],
        description: json["Description"],
        specification: json["Specification"],
        couponId: json["CouponID"],
        couponTitle: json["CouponTitle"],
        discount: json["Discount"],
        couponValue: json["CouponValue"],
        expiryDate: json["ExpiryDate"],
        productImage: json["Product_Image"],
        rating: json["Rating"],
        couponDetails: json["CouponDetails"],
        couponType: json["CouponType"],
        couponLeft: json["CouponLeft"],
        purchaseAmount: json["PurchaseAmount"],
        saveAmount: json["SaveAmount"],
        couponAvailableFlag: json["CouponAvailableFlag"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "Name": name,
        "BusinessID": businessId,
        "BusinessName": businessName,
        "Price": price,
        "OfferPrice": offerPrice,
        "ShopPrice": shopPrice,
        "Description": description,
        "Specification": specification,
        "CouponID": couponId,
        "CouponTitle": couponTitle,
        "Discount": discount,
        "CouponValue": couponValue,
        "ExpiryDate": expiryDate,
        "Product_Image": productImage,
        "Rating": rating,
        "CouponDetails": couponDetails,
        "CouponType": couponType,
        "CouponLeft": couponLeft,
        "PurchaseAmount": purchaseAmount,
        "SaveAmount": saveAmount,
        "CouponAvailableFlag": couponAvailableFlag,
      };
}
