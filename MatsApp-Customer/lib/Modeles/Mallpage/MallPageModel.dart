// To parse this JSON data, do
//
//     final mallPageModel = mallPageModelFromMap(jsonString);

import 'dart:convert';

class MallPageModel {
  MallPageModel({
    this.mallInfo,
    this.businessList,
  });

  List<MallInfo> mallInfo;
  List<BusinessList> businessList;

  factory MallPageModel.fromJson(String str) =>
      MallPageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MallPageModel.fromMap(Map<String, dynamic> json) => MallPageModel(
        mallInfo: List<MallInfo>.from(
            json["MallInfo"].map((x) => MallInfo.fromMap(x))),
        businessList: List<BusinessList>.from(
            json["BusinessList"].map((x) => BusinessList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "MallInfo": List<dynamic>.from(mallInfo.map((x) => x.toMap())),
        "BusinessList": List<dynamic>.from(businessList.map((x) => x.toMap())),
      };
}

class BusinessList {
  BusinessList({
    this.pkBusinessId,
    this.businessName,
    this.coverImageUrl,
    this.provideOffers,
    this.isMall,
    this.rating,
    this.wishListId,
    this.distanceinKm,
  });

  int pkBusinessId;
  String businessName;
  String coverImageUrl;
  String provideOffers;
  bool isMall;
  int rating;
  int wishListId;
  String distanceinKm;

  factory BusinessList.fromJson(String str) =>
      BusinessList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessList.fromMap(Map<String, dynamic> json) => BusinessList(
        pkBusinessId: json["PK_BusinessID"],
        businessName: json["BusinessName"],
        coverImageUrl: json["CoverImageUrl"],
        provideOffers: json["ProvideOffers"],
        isMall: json["IsMall"],
        rating: json["Rating"],
        wishListId: json["WishListID"],
        distanceinKm: json["DistanceinKm"],
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
      };
}

class MallInfo {
  MallInfo({
    this.businessName,
    this.businesssCategory,
    this.openingTime,
    this.closingTime,
    this.address,
    this.description,
    this.coverImage,
    this.rating,
    this.wishListId,
    this.mobile,
  });

  String businessName;
  dynamic businesssCategory;
  String openingTime;
  String closingTime;
  String address;
  String description;
  String coverImage;
  int rating;
  int wishListId;
  dynamic mobile;

  factory MallInfo.fromJson(String str) => MallInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MallInfo.fromMap(Map<String, dynamic> json) => MallInfo(
        businessName: json["BusinessName"],
        businesssCategory: json["BusinesssCategory"],
        openingTime: json["OpeningTime"],
        closingTime: json["ClosingTime"],
        address: json["Address"],
        description: json["Description"],
        coverImage: json["CoverImage"],
        rating: json["Rating"],
        wishListId: json["WishListID"],
        mobile: json["Mobile"],
      );

  Map<String, dynamic> toMap() => {
        "BusinessName": businessName,
        "BusinesssCategory": businesssCategory,
        "OpeningTime": openingTime,
        "ClosingTime": closingTime,
        "Address": address,
        "Description": description,
        "CoverImage": coverImage,
        "Rating": rating,
        "WishListID": wishListId,
        "Mobile": mobile,
      };
}
