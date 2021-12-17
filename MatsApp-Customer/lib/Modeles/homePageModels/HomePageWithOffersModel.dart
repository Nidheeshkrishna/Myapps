// To parse this JSON data, do
//
//     final homePageWithOffersModel = homePageWithOffersModelFromMap(jsonString);

import 'dart:convert';

class HomePageWithOffersModel {
  HomePageWithOffersModel({
    this.top9Store,
    this.hotspot,
    this.trendingOffer,
    this.offer1,
    this.offer2,
    this.offer3,
    this.banners1,
    this.banners2,
    this.banners3,
    this.banners4,
    this.apiKeyStatus,
  });

  List<Top9Store> top9Store;
  List<Hotspot> hotspot;
  List<Offer1> trendingOffer;
  List<Offer1> offer1;
  List<Offer1> offer2;
  List<Offer1> offer3;
  List<Banners> banners1;
  List<Banners> banners2;
  List<Banners> banners3;
  List<Banners> banners4;
  bool apiKeyStatus;

  factory HomePageWithOffersModel.fromJson(String str) =>
      HomePageWithOffersModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomePageWithOffersModel.fromMap(Map<String, dynamic> json) =>
      HomePageWithOffersModel(
        top9Store: List<Top9Store>.from(
            json["Top9Store"].map((x) => Top9Store.fromMap(x))),
        hotspot:
            List<Hotspot>.from(json["Hotspot"].map((x) => Hotspot.fromMap(x))),
        trendingOffer: List<Offer1>.from(
            json["TrendingOffer"].map((x) => Offer1.fromMap(x))),
        offer1: List<Offer1>.from(json["Offer1"].map((x) => Offer1.fromMap(x))),
        offer2: List<Offer1>.from(json["Offer2"].map((x) => Offer1.fromMap(x))),
        offer3: List<Offer1>.from(json["Offer3"].map((x) => Offer1.fromMap(x))),
        banners1:
            List<Banners>.from(json["Banners1"].map((x) => Banners.fromMap(x))),
        banners2:
            List<Banners>.from(json["Banners2"].map((x) => Banners.fromMap(x))),
        banners3:
            List<Banners>.from(json["Banners3"].map((x) => Banners.fromMap(x))),
        banners4:
            List<Banners>.from(json["Banners4"].map((x) => Banners.fromMap(x))),
        apiKeyStatus: json["ApiKey_status"],
      );

  Map<String, dynamic> toMap() => {
        "Top9Store": List<dynamic>.from(top9Store.map((x) => x.toMap())),
        "Hotspot": List<dynamic>.from(hotspot.map((x) => x.toMap())),
        "TrendingOffer":
            List<dynamic>.from(trendingOffer.map((x) => x.toMap())),
        "Offer1": List<dynamic>.from(offer1.map((x) => x.toMap())),
        "Offer2": List<dynamic>.from(offer2.map((x) => x.toMap())),
        "Offer3": List<dynamic>.from(offer3.map((x) => x.toMap())),
        "Banners1": List<dynamic>.from(banners1.map((x) => x.toMap())),
        "Banners2": List<dynamic>.from(banners2.map((x) => x.toMap())),
        "Banners3": List<dynamic>.from(banners3.map((x) => x.toMap())),
        "Banners4": List<dynamic>.from(banners4.map((x) => x.toMap())),
        "ApiKey_status": apiKeyStatus,
      };
}

class Banners {
  Banners({
    this.id,
    this.name,
    this.imageUrl,
    this.priority,
    this.redirectionPage,
    this.redirectionUrl,
    this.redirectionId,
    this.businessName,
    this.position,
  });

  int id;
  String name;
  String imageUrl;
  String priority;
  String redirectionPage;
  String redirectionUrl;
  int redirectionId;
  String businessName;
  String position;

  factory Banners.fromJson(String str) => Banners.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Banners.fromMap(Map<String, dynamic> json) => Banners(
        id: json["ID"],
        name: json["Name"],
        imageUrl: json["ImageURL"],
        priority: json["Priority"],
        redirectionPage: json["redirectionPage"],
        redirectionUrl: json["redirectionURL"],
        redirectionId: json["redirectionID"],
        businessName: json["BusinessName"],
        position: json["Position"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "Name": name,
        "ImageURL": imageUrl,
        "Priority": priority,
        "redirectionPage": redirectionPage,
        "redirectionURL": redirectionUrl,
        "redirectionID": redirectionId,
        "BusinessName": businessName,
        "Position": position,
      };
}

class Hotspot {
  Hotspot({
    this.hotspotId,
    this.businessId,
    this.businessName,
    this.businessAddress,
    this.expiryDate,
    this.openingTime,
    this.closingTime,
    this.status,
    this.coverImageUrl,
  });

  int hotspotId;
  int businessId;
  String businessName;
  String businessAddress;
  String expiryDate;
  String openingTime;
  String closingTime;
  String status;
  String coverImageUrl;

  factory Hotspot.fromJson(String str) => Hotspot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Hotspot.fromMap(Map<String, dynamic> json) => Hotspot(
        hotspotId: json["HotspotID"],
        businessId: json["BusinessID"],
        businessName: json["BusinessName"],
        businessAddress: json["BusinessAddress"],
        expiryDate: json["ExpiryDate"],
        openingTime: json["OpeningTime"],
        closingTime: json["ClosingTime"],
        status: json["Status"],
        coverImageUrl: json["CoverImageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "HotspotID": hotspotId,
        "BusinessID": businessId,
        "BusinessName": businessName,
        "BusinessAddress": businessAddress,
        "ExpiryDate": expiryDate,
        "OpeningTime": openingTime,
        "ClosingTime": closingTime,
        "Status": status,
        "CoverImageUrl": coverImageUrl,
      };
}

class Offer1 {
  Offer1({
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
    this.offerHeading,
    this.offerHeadingId,
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
  String offerHeading;
  String offerHeadingId;

  factory Offer1.fromJson(String str) => Offer1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Offer1.fromMap(Map<String, dynamic> json) => Offer1(
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
        offerHeading: json["OfferHeading"],
        offerHeadingId: json["OfferHeadingID"],
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
        "OfferHeading": offerHeading,
        "OfferHeadingID": offerHeadingId
      };
}

class Top9Store {
  Top9Store({
    this.pkBusinessId,
    this.businessName,
    this.coverImageUrl,
    this.provideOffers,
    this.isMall,
    this.rating,
    this.wishListId,
    this.distanceinKm,
    this.town,
    this.apiKey,
  });

  int pkBusinessId;
  String businessName;
  String coverImageUrl;
  String provideOffers;
  bool isMall;
  int rating;
  int wishListId;
  dynamic distanceinKm;
  dynamic town;
  bool apiKey;

  factory Top9Store.fromJson(String str) => Top9Store.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Top9Store.fromMap(Map<String, dynamic> json) => Top9Store(
        pkBusinessId: json["PK_BusinessID"],
        businessName: json["BusinessName"],
        coverImageUrl: json["CoverImageUrl"],
        provideOffers: json["ProvideOffers"],
        isMall: json["IsMall"],
        rating: json["Rating"],
        wishListId: json["WishListID"],
        distanceinKm: json["DistanceinKm"],
        town: json["Town"],
        apiKey: json["api_key"],
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
        "api_key": apiKey,
      };
}
