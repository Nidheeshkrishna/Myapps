// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

class ProductModel {
  ProductModel({
    this.result,
  });

  Result result;
 

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        result: Result.fromMap(json["result"]),
        //result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": result.toMap(),
      };

  // Map<String, dynamic> toMap() => {
  //       "result": List<dynamic>.from(result.map((x) => x.toMap())),
  //     };
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
  });

  int id;
  String name;
  int businessId;
  String businessName;
  double price;
  double offerPrice;
  double shopPrice;
  String description;
  String specification;
  String couponId;
  String couponTitle;
  double discount;
  double couponValue;
  String expiryDate;
  String productImage;
  int rating;
  String couponDetails;
  String couponType;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["ID"] ?? 0,
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
      );

  Map<String, dynamic> toMap() => {
        "ID": id ?? 0,
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
      };
}
