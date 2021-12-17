// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromMap(jsonString);

import 'dart:convert';

class HomePageModel {
  HomePageModel({
    this.top9Store,
    this.exclusiveDeals,
    this.hotspot,
    this.trendingOffer,
    this.dealsoftheDay,
    this.discountForyou,
    this.banners1,
    this.banners2,
    this.banners3,
    this.banners4,
    this.apiKeyStatus,
  });

  List<Top9Store> top9Store;
  List<DealsoftheDay> exclusiveDeals;
  List<Hotspot> hotspot;
  List<TrendingOffer> trendingOffer;
  List<DealsoftheDay> dealsoftheDay;
  List<DealsoftheDay> discountForyou;
  List<Banners> banners1;
  List<Banners> banners2;
  List<Banners> banners3;
  List<Banners> banners4;
  bool apiKeyStatus;

  factory HomePageModel.fromJson(String str) =>
      HomePageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomePageModel.fromMap(Map<String, dynamic> json) => HomePageModel(
        top9Store: List<Top9Store>.from(
            json["Top9Store"].map((x) => Top9Store.fromMap(x))),
        exclusiveDeals: List<DealsoftheDay>.from(
            json["ExclusiveDeals"].map((x) => DealsoftheDay.fromMap(x))),
        hotspot:
            List<Hotspot>.from(json["Hotspot"].map((x) => Hotspot.fromMap(x))),
        trendingOffer: List<TrendingOffer>.from(
            json["TrendingOffer"].map((x) => TrendingOffer.fromMap(x))),
        dealsoftheDay: List<DealsoftheDay>.from(
            json["DealsoftheDay"].map((x) => DealsoftheDay.fromMap(x))),
        discountForyou: List<DealsoftheDay>.from(
            json["DiscountForyou"].map((x) => DealsoftheDay.fromMap(x))),
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
        "ExclusiveDeals":
            List<dynamic>.from(exclusiveDeals.map((x) => x.toMap())),
        "Hotspot": List<dynamic>.from(hotspot.map((x) => x.toMap())),
        "TrendingOffer":
            List<dynamic>.from(trendingOffer.map((x) => x.toMap())),
        "DealsoftheDay":
            List<dynamic>.from(dealsoftheDay.map((x) => x.toMap())),
        "DiscountForyou":
            List<dynamic>.from(discountForyou.map((x) => x.toMap())),
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

class DealsoftheDay {
  DealsoftheDay(
      {this.couponId,
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
      this.shopPrice,
      this.matsappPrice,
      this.productPrice,
      this.wishListId,
      this.rating,
      this.distanceinKm,
      this.endingDateTime});

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
  String shopPrice;
  String matsappPrice;
  String productPrice;
  int wishListId;
  int rating;
  String distanceinKm;
  String endingDateTime;

  factory DealsoftheDay.fromJson(String str) =>
      DealsoftheDay.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DealsoftheDay.fromMap(Map<String, dynamic> json) => DealsoftheDay(
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
      shopPrice: json["ShopPrice"] == null ? null : json["ShopPrice"],
      matsappPrice: json["MatsappPrice"],
      productPrice: json["ProductPrice"] == null ? null : json["ProductPrice"],
      wishListId: json["WishListID"],
      rating: json["Rating"],
      distanceinKm: json["DistanceinKm"],
      endingDateTime:
          json["EndingDateTime"] == null ? "" : json["EndingDateTime"]);

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
        "ShopPrice": shopPrice == null ? null : shopPrice,
        "MatsappPrice": matsappPrice,
        "ProductPrice": productPrice == null ? null : productPrice,
        "WishListID": wishListId,
        "Rating": rating,
        "DistanceinKm": distanceinKm,
        "EndingDateTime": endingDateTime ?? ""
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
  dynamic businessAddress;
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

class TrendingOffer {
  TrendingOffer({
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

  factory TrendingOffer.fromJson(String str) =>
      TrendingOffer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrendingOffer.fromMap(Map<String, dynamic> json) => TrendingOffer(
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
