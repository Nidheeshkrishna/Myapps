// To parse this JSON data, do
//
//     final searchListModel = searchListModelFromMap(jsonString);

import 'dart:convert';

class SearchListModel {
  SearchListModel({
    this.offers,
    this.stores,
    this.allOffers,
    this.allStores,
    this.product,
    this.allProduct,
  });

  List<Offer> offers;
  List<Store> stores;
  List<Offer> allOffers;
  List<Store> allStores;
  List<Product> product;
  List<Product> allProduct;

  factory SearchListModel.fromJson(String str) =>
      SearchListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchListModel.fromMap(Map<String, dynamic> json) => SearchListModel(
        offers: json["Offers"] == null
            ? null
            : List<Offer>.from(json["Offers"].map((x) => Offer.fromMap(x))),
        stores: json["Stores"] == null
            ? null
            : List<Store>.from(json["Stores"].map((x) => Store.fromMap(x))),
        allOffers: json["AllOffers"] == null
            ? null
            : List<Offer>.from(json["AllOffers"].map((x) => Offer.fromMap(x))),
        allStores: json["AllStores"] == null
            ? null
            : List<Store>.from(json["AllStores"].map((x) => Store.fromMap(x))),
        product: json["product"] == null
            ? null
            : List<Product>.from(
                json["product"].map((x) => Product.fromMap(x))),
        allProduct: json["AllProduct"] == null
            ? null
            : List<Product>.from(
                json["AllProduct"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Offers": offers == null
            ? null
            : List<dynamic>.from(offers.map((x) => x.toMap())),
        "Stores": stores == null
            ? null
            : List<dynamic>.from(stores.map((x) => x.toMap())),
        "AllOffers": allOffers == null
            ? null
            : List<dynamic>.from(allOffers.map((x) => x.toMap())),
        "AllStores": allStores == null
            ? null
            : List<dynamic>.from(allStores.map((x) => x.toMap())),
        "product": product == null
            ? null
            : List<dynamic>.from(product.map((x) => x.toMap())),
        "AllProduct": allProduct == null
            ? null
            : List<dynamic>.from(allProduct.map((x) => x.toMap())),
      };
}

class Offer {
  Offer({
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
  });

  int offerId;
  String offerName;
  int discount;
  int mrp;
  int businessId;
  String businessName;
  String productImage;
  int rating;
  dynamic offerPrice;
  int wishListId;
  String distanceinKm;

  factory Offer.fromJson(String str) => Offer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Offer.fromMap(Map<String, dynamic> json) => Offer(
        offerId: json["OfferID"] == null ? null : json["OfferID"],
        offerName: json["OfferName"] == null ? null : json["OfferName"],
        discount: json["Discount"] == null ? null : json["Discount"],
        mrp: json["MRP"] == null ? null : json["MRP"],
        businessId: json["BusinessID"] == null ? null : json["BusinessID"],
        businessName:
            json["BusinessName"] == null ? null : json["BusinessName"],
        productImage:
            json["ProductImage"] == null ? null : json["ProductImage"],
        rating: json["Rating"] == null ? null : json["Rating"],
        offerPrice: json["OfferPrice"],
        wishListId: json["WishListID"] == null ? null : json["WishListID"],
        distanceinKm:
            json["DistanceinKm"] == null ? null : json["DistanceinKm"],
      );

  Map<String, dynamic> toMap() => {
        "OfferID": offerId == null ? null : offerId,
        "OfferName": offerName == null ? null : offerName,
        "Discount": discount == null ? null : discount,
        "MRP": mrp == null ? null : mrp,
        "BusinessID": businessId == null ? null : businessId,
        "BusinessName": businessName == null ? null : businessName,
        "ProductImage": productImage == null ? null : productImage,
        "Rating": rating == null ? null : rating,
        "OfferPrice": offerPrice,
        "WishListID": wishListId == null ? null : wishListId,
        "DistanceinKm": distanceinKm == null ? null : distanceinKm,
      };
}

class Product {
  Product({
    this.couponId,
    this.couponTitle,
    this.productId,
    this.productName,
    this.productImage,
    this.productPrice,
    this.matsappPrice,
    this.rating,
    this.businessId,
    this.businessName,
    this.matsappDiscount,
    this.distanceinKm,
  });

  String couponId;
  String couponTitle;
  int productId;
  String productName;
  String productImage;
  double productPrice;
  double matsappPrice;
  int rating;
  int businessId;
  String businessName;
  String matsappDiscount;
  String distanceinKm;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        couponId: json["CouponID"] == null ? null : json["CouponID"],
        couponTitle: json["CouponTitle"] == null ? null : json["CouponTitle"],
        productId: json["ProductID"] == null ? null : json["ProductID"],
        productName: json["ProductName"] == null ? null : json["ProductName"],
        productImage:
            json["ProductImage"] == null ? null : json["ProductImage"],
        productPrice:
            json["ProductPrice"] == null ? null : json["ProductPrice"],
        matsappPrice: json["MatsappPrice"] == null
            ? null
            : json["MatsappPrice"].toDouble(),
        rating: json["Rating"] == null ? null : json["Rating"],
        businessId: json["BusinessID"] == null ? null : json["BusinessID"],
        businessName:
            json["BusinessName"] == null ? null : json["BusinessName"],
        matsappDiscount:
            json["MatsappDiscount"] == null ? null : json["MatsappDiscount"],
        distanceinKm:
            json["DistanceinKm"] == null ? null : json["DistanceinKm"],
      );

  Map<String, dynamic> toMap() => {
        "CouponID": couponId == null ? null : couponId,
        "CouponTitle": couponTitle == null ? null : couponTitle,
        "ProductID": productId == null ? null : productId,
        "ProductName": productName == null ? null : productName,
        "ProductImage": productImage == null ? null : productImage,
        "ProductPrice": productPrice == null ? null : productPrice,
        "MatsappPrice": matsappPrice == null ? null : matsappPrice,
        "Rating": rating == null ? null : rating,
        "BusinessID": businessId == null ? null : businessId,
        "BusinessName": businessName == null ? null : businessName,
        "MatsappDiscount": matsappDiscount == null ? null : matsappDiscount,
        "DistanceinKm": distanceinKm == null ? null : distanceinKm,
      };
}

class Store {
  Store({
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
  String distanceinKm;
  String town;
  bool apiKey;

  factory Store.fromJson(String str) => Store.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Store.fromMap(Map<String, dynamic> json) => Store(
        pkBusinessId:
            json["PK_BusinessID"] == null ? null : json["PK_BusinessID"],
        businessName:
            json["BusinessName"] == null ? null : json["BusinessName"],
        coverImageUrl:
            json["CoverImageUrl"] == null ? null : json["CoverImageUrl"],
        provideOffers:
            json["ProvideOffers"] == null ? null : json["ProvideOffers"],
        isMall: json["IsMall"] == null ? null : json["IsMall"],
        rating: json["Rating"] == null ? null : json["Rating"],
        wishListId: json["WishListID"] == null ? null : json["WishListID"],
        distanceinKm:
            json["DistanceinKm"] == null ? null : json["DistanceinKm"],
        town: json["Town"],
        apiKey: json["api_key"] == null ? null : json["api_key"],
      );

  Map<String, dynamic> toMap() => {
        "PK_BusinessID": pkBusinessId == null ? null : pkBusinessId,
        "BusinessName": businessName == null ? null : businessName,
        "CoverImageUrl": coverImageUrl == null ? null : coverImageUrl,
        "ProvideOffers": provideOffers == null ? null : provideOffers,
        "IsMall": isMall == null ? null : isMall,
        "Rating": rating == null ? null : rating,
        "WishListID": wishListId == null ? null : wishListId,
        "DistanceinKm": distanceinKm == null ? null : distanceinKm,
        "Town": town,
        "api_key": apiKey == null ? null : apiKey,
      };
}
