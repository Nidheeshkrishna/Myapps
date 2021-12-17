// To parse this JSON data, do
//
//     final exclusiveDealsModel1 = exclusiveDealsModel1FromMap(jsonString);

import 'dart:convert';

class ExclusiveDealsModel1 {
  ExclusiveDealsModel1({
    this.result,
    this.list1,
    this.list2,
    //this.dateandTime,
    this.apiKeyStatus,
  });

  List<List1> result;
  List<List1> list1;
  List<List1> list2;
  //
  bool apiKeyStatus;

  factory ExclusiveDealsModel1.fromJson(String str) =>
      ExclusiveDealsModel1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExclusiveDealsModel1.fromMap(Map<String, dynamic> json) =>
      ExclusiveDealsModel1(
        result: List<List1>.from(json["result"].map((x) => List1.fromMap(x))),
        list1: List<List1>.from(json["List1"].map((x) => List1.fromMap(x))),
        list2: List<List1>.from(json["List2"].map((x) => List1.fromMap(x))),
        // dateandTime: List<DateandTime>.from(
        //     json["DateandTime"].map((x) => DateandTime.fromMap(x))),
        apiKeyStatus: json["ApiKey_status"],
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
        "List1": List<dynamic>.from(list1.map((x) => x.toMap())),
        "List2": List<dynamic>.from(list2.map((x) => x.toMap())),
        // "DateandTime": List<dynamic>.from(dateandTime.map((x) => x.toMap())),
        "ApiKey_status": apiKeyStatus,
      };
}

class DateandTime {
  DateandTime({
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
  });

  String startDate;
  String endDate;
  String startTime;
  String endTime;

  factory DateandTime.fromJson(String str) =>
      DateandTime.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DateandTime.fromMap(Map<String, dynamic> json) => DateandTime(
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        startTime: json["StartTime"],
        endTime: json["EndTime"],
      );

  Map<String, dynamic> toMap() => {
        "StartDate": startDate,
        "EndDate": endDate,
        "StartTime": startTime,
        "EndTime": endTime,
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
        "MatsappPrice": matsappPrice ?? "0",
        "ProductPrice": productPrice ?? "0",
        "WishListID": wishListId,
        "Rating": rating,
        "DistanceinKm": distanceinKm,
      };
}

enum BusinessName { RAMS_SUPERMARKET, NANDILATH_G_MART, THREE_ROSES_FASHIONS }

final businessNameValues = EnumValues({
  "Nandilath G Mart": BusinessName.NANDILATH_G_MART,
  "rams supermarket": BusinessName.RAMS_SUPERMARKET,
  "THREE ROSES FASHIONS": BusinessName.THREE_ROSES_FASHIONS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
