// To parse this JSON data, do
//
//     final dealsOftheDayModel = dealsOftheDayModelFromMap(jsonString);

import 'dart:convert';

class DealsOftheDayModel {
  DealsOftheDayModel({
    this.result,
    this.list1,
    this.list2,
    this.apiKeyStatus,
  });

  List<List1> result;
  List<List1> list1;
  List<List1> list2;
  bool apiKeyStatus;

  factory DealsOftheDayModel.fromJson(String str) =>
      DealsOftheDayModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DealsOftheDayModel.fromMap(Map<String, dynamic> json) =>
      DealsOftheDayModel(
        result: List<List1>.from(json["result"].map((x) => List1.fromMap(x))),
        list1: List<List1>.from(json["List1"].map((x) => List1.fromMap(x))),
        list2: List<List1>.from(json["List2"].map((x) => List1.fromMap(x))),
        apiKeyStatus: json["ApiKey_status"],
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
        "List1": List<dynamic>.from(list1.map((x) => x.toMap())),
        "List2": List<dynamic>.from(list2.map((x) => x.toMap())),
        "ApiKey_status": apiKeyStatus,
      };
}

class List1 {
  List1({
    this.couponId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.productId,
    this.productName,
    this.businessId,
    this.businessName,
    this.productImage,
    this.matsappDiscount,
    this.matsappPrice,
    this.productPrice,
    this.wishListId,
    this.rating,
    this.distanceinKm,

    
  });

  String couponId;
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  int productId;
  String productName;
  int businessId;
  String businessName;
  String productImage;
  String matsappDiscount;
  String matsappPrice;
  String productPrice;
  int wishListId;
  int rating;
  String distanceinKm;

  factory List1.fromJson(String str) => List1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory List1.fromMap(Map<String, dynamic> json) => List1(
        couponId: json["CouponID"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        startTime: json["StartTime"],
        endTime: json["EndTime"],
        productId: json["ProductID"],
        productName: json["ProductName"],
        businessId: json["BusinessID"],
        businessName: json["BusinessName"],
        productImage: json["ProductImage"],
        matsappDiscount: json["MatsappDiscount"],
        matsappPrice: json["MatsappPrice"],
        productPrice: json["ProductPrice"],
        wishListId: json["WishListID"],
        rating: json["Rating"],
        distanceinKm: json["DistanceinKm"],
      );

  Map<String, dynamic> toMap() => {
        "CouponID": couponId,
        "StartDate": startDate,
        "EndDate": endDate,
        "StartTime": startTime,
        "EndTime": endTime,
        "ProductID": productId,
        "ProductName": productName,
        "BusinessID": businessId,
        "BusinessName": businessName,
        "ProductImage": productImage,
        "MatsappDiscount": matsappDiscount,
        "MatsappPrice": matsappPrice,
        "ProductPrice": productPrice,
        "WishListID": wishListId,
        "Rating": rating,
        "DistanceinKm": distanceinKm,
      };
}
