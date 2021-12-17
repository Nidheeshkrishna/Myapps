// To parse this JSON data, do
//
//     final topStoresModel = topStoresModelFromMap(jsonString);

import 'dart:convert';

class TopStoresModel {
  TopStoresModel({
    this.result,
    this.list1,
    this.list2,
    this.apiKeyStatus,
  });

  List<List1> result;
  List<List1> list1;
  List<List1> list2;
  bool apiKeyStatus;

  factory TopStoresModel.fromJson(String str) =>
      TopStoresModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TopStoresModel.fromMap(Map<String, dynamic> json) => TopStoresModel(
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
  dynamic town;

  factory List1.fromJson(String str) => List1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory List1.fromMap(Map<String, dynamic> json) => List1(
        pkBusinessId: json["PK_BusinessID"],
        businessName: json["BusinessName"],
        coverImageUrl: json["CoverImageUrl"],
        provideOffers: json["ProvideOffers"],
        isMall: json["IsMall"],
        rating: json["Rating"],
        wishListId: json["WishListID"],
        distanceinKm:
            json["DistanceinKm"] == null ? null : json["DistanceinKm"],
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
        "DistanceinKm": distanceinKm == null ? null : distanceinKm,
        "Town": town,
      };
}

enum ProvideOffers { SAVE_20, UPTO_20, UPTO_10, SAVE_10 }

final provideOffersValues = EnumValues({
  "SAVE 10": ProvideOffers.SAVE_10,
  "SAVE 20": ProvideOffers.SAVE_20,
  "UPTO  10": ProvideOffers.UPTO_10,
  "UPTO  20": ProvideOffers.UPTO_20
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
