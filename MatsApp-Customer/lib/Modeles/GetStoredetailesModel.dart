// To parse this JSON data, do
//
//     final getStoredetailesModel = getStoredetailesModelFromMap(jsonString);

import 'dart:convert';

class GetStoredetailesModel {
  GetStoredetailesModel({
    this.result,
    this.productoffers,
    this.offersList,
    this.storeCoupon,
    this.images,
    this.allProducts,
    this.allOffers,
  });

  List<Result> result;
  List<AllProduct> productoffers;
  List<AllOffer> offersList;
  List<AllProduct> storeCoupon;
  List<Images> images;
  List<AllProduct> allProducts;
  List<AllOffer> allOffers;

  factory GetStoredetailesModel.fromJson(String str) =>
      GetStoredetailesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetStoredetailesModel.fromMap(Map<String, dynamic> json) =>
      GetStoredetailesModel(
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
        productoffers: List<AllProduct>.from(
            json["productoffers"].map((x) => AllProduct.fromMap(x))),
        offersList: List<AllOffer>.from(
            json["offersList"].map((x) => AllOffer.fromMap(x))),
        storeCoupon: List<AllProduct>.from(
            json["StoreCoupon"].map((x) => AllProduct.fromMap(x))),
        images: json["Images"] == null
            ? null
            : List<Images>.from(json["Images"].map((x) => Images.fromMap(x))),
        allProducts: List<AllProduct>.from(
            json["AllProducts"].map((x) => AllProduct.fromMap(x))),
        allOffers: List<AllOffer>.from(
            json["AllOffers"].map((x) => AllOffer.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
        "productoffers":
            List<dynamic>.from(productoffers.map((x) => x.toMap())),
        "offersList": List<dynamic>.from(offersList.map((x) => x.toMap())),
        "StoreCoupon": List<dynamic>.from(storeCoupon.map((x) => x.toMap())),
        "Images": images == null
            ? null
            : List<dynamic>.from(images.map((x) => x.toMap())),
        "AllProducts": List<dynamic>.from(allProducts.map((x) => x.toMap())),
        "AllOffers": List<dynamic>.from(allOffers.map((x) => x.toMap())),
      };
}

class AllOffer {
  AllOffer({
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
  dynamic distanceinKm;
  String saveAmount;

  factory AllOffer.fromJson(String str) => AllOffer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllOffer.fromMap(Map<String, dynamic> json) => AllOffer(
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

class AllProduct {
  AllProduct({
    this.couponId,
    this.couponTitle,
    this.discount,
    this.productId,
    this.productName,
    this.businessId,
    this.businessName,
    this.productImage,
    this.productPrice,
    this.matsappPrice,
    this.couponValue,
    this.rating,
    this.couponExpiryDate,
    this.coupondetails,
    this.couponType,
    this.endDate,
    this.endTime,
    this.couponLeft,
    this.couponAvailableFlag,
    this.freeCouponFlag,
  });

  String couponId;
  String couponTitle;
  int discount;
  int productId;
  String productName;
  dynamic businessId;
  dynamic businessName;
  String productImage;
  double productPrice;
  double matsappPrice;
  int couponValue;
  int rating;
  String couponExpiryDate;
  String coupondetails;
  String couponType;
  String endDate;
  String endTime;
  String couponLeft;
  String couponAvailableFlag;
  String freeCouponFlag;

  factory AllProduct.fromJson(String str) =>
      AllProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllProduct.fromMap(Map<String, dynamic> json) => AllProduct(
        couponId: json["CouponID"],
        couponTitle: json["CouponTitle"],
        discount: json["Discount"],
        productId: json["ProductID"],
        productName: json["ProductName"] == null ? null : json["ProductName"],
        businessId: json["BusinessID"],
        businessName: json["BusinessName"],
        productImage: json["ProductImage"],
        productPrice:
            json["ProductPrice"] == null ? null : json["ProductPrice"],
        matsappPrice:
            json["MatsappPrice"] == null ? null : json["MatsappPrice"],
        couponValue: json["CouponValue"] == null ? null : json["CouponValue"],
        rating: json["Rating"],
        couponExpiryDate:
            json["CouponExpiryDate"] == null ? null : json["CouponExpiryDate"],
        coupondetails:
            json["coupondetails"] == null ? null : json["coupondetails"],
        couponType: json["CouponType"] == null ? null : json["CouponType"],
        endDate: json["EndDate"] == null ? null : json["EndDate"],
        endTime: json["EndTime"] == null ? null : json["EndTime"],
        couponLeft: json["CouponLeft"] == null ? null : json["CouponLeft"],
        couponAvailableFlag: json["CouponAvailableFlag"] == null
            ? null
            : json["CouponAvailableFlag"],
        freeCouponFlag:
            json["FreeCouponFlag"] == null ? null : json["FreeCouponFlag"],
      );

  Map<String, dynamic> toMap() => {
        "CouponID": couponId,
        "CouponTitle": couponTitle,
        "Discount": discount,
        "ProductID": productId,
        "ProductName": productName == null ? null : productName,
        "BusinessID": businessId,
        "BusinessName": businessName,
        "ProductImage": productImage,
        "ProductPrice": productPrice == null ? null : productPrice,
        "MatsappPrice": matsappPrice == null ? null : matsappPrice,
        "CouponValue": couponValue == null ? null : couponValue,
        "Rating": rating,
        "CouponExpiryDate": couponExpiryDate == null ? null : couponExpiryDate,
        "coupondetails": coupondetails == null ? null : coupondetails,
        "CouponType": couponType == null ? null : couponType,
        "EndDate": endDate == null ? null : endDate,
        "EndTime": endTime == null ? null : endTime,
        "CouponLeft": couponLeft == null ? null : couponLeft,
        "CouponAvailableFlag":
            couponAvailableFlag == null ? null : couponAvailableFlag,
        "FreeCouponFlag": freeCouponFlag == null ? null : freeCouponFlag,
      };
}

class Images {
  Images({
    this.imgId,
    this.imgName,
    this.imgUrl,
  });

  int imgId;
  String imgName;
  String imgUrl;

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        imgId: json["Img_ID"] == null ? null : json["Img_ID"],
        imgName: json["Img_Name"] == null ? null : json["Img_Name"],
        imgUrl: json["Img_Url"] == null ? null : json["Img_Url"],
      );

  Map<String, dynamic> toMap() => {
        "Img_ID": imgId == null ? null : imgId,
        "Img_Name": imgName == null ? null : imgName,
        "Img_Url": imgUrl == null ? null : imgUrl,
      };
}

class Result {
  Result(
      {this.businessId,
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
      this.latitude,
      this.longitude,
      this.storeDetails,
      this.giftFlag});

  int businessId;
  String businessName;
  String businesssCategory;
  String openingTime;
  String closingTime;
  String address;
  String description;
  String coverImage;
  int rating;
  int wishListId;
  String mobile;
  double latitude;
  double longitude;
  String storeDetails;
  String giftFlag;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        businessId: json["BusinessID"],
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
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        storeDetails: json["StoreDetails"],
        giftFlag: json["GiftFlag"],
      );

  Map<String, dynamic> toMap() => {
        "BusinessID": businessId,
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
        "latitude": latitude,
        "longitude": longitude,
        "StoreDetails": storeDetails,
        "GiftFlag": giftFlag,
      };
}
