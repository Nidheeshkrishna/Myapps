// To parse this JSON data, do
//
//     final storeDealsModel = storeDealsModelFromMap(jsonString);

import 'dart:convert';

class StoreDealsModel {
  StoreDealsModel({
    this.result,
    this.list1,
    this.list2,
    this.apiKeyStatus,
  });

  List<List1> result;
  List<List1> list1;
  List<List1> list2;
  bool apiKeyStatus;

  factory StoreDealsModel.fromJson(String str) =>
      StoreDealsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoreDealsModel.fromMap(Map<String, dynamic> json) => StoreDealsModel(
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
    this.offerId,
    this.offerName,
    this.discount,
    this.mrp,
    this.businessId,
    this.businessName,
    this.productImage,
    this.rating,
    this.offerPrice,
    this.wishListId,
    this.distanceinKm,
    this.saveAmount,
  });

  int offerId;
  String offerName;
  int discount;
  int mrp;
  int businessId;
  String businessName;
  String productImage;
  int rating;
  String offerPrice;
  int wishListId;

  String distanceinKm;
  String saveAmount;

  factory List1.fromJson(String str) => List1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory List1.fromMap(Map<String, dynamic> json) => List1(
        offerId: json["OfferID"],
        offerName: json["OfferName"],
        discount: json["Discount"],
        mrp: json["MRP"],
        businessId: json["BusinessID"],
        businessName: json["BusinessName"],
        productImage: json["ProductImage"],
        rating: json["Rating"],
        offerPrice: json["OfferPrice"],
        wishListId: json["WishListID"],
        distanceinKm: json["DistanceinKm"],
           saveAmount: json["SaveAmount"],
      );

  Map<String, dynamic> toMap() => {
        "OfferID": offerId,
        "OfferName": offerName,
        "Discount": discount,
        "MRP": mrp,
        "BusinessID": businessId,
        "BusinessName": businessName,
        "ProductImage": productImage,
        "Rating": rating,
        "OfferPrice": offerPrice,
        "WishListID": wishListId,
        "DistanceinKm": distanceinKm,
         "SaveAmount": saveAmount,
      };
}
