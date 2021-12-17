// To parse this JSON data, do
//
//     final productInAreaModel = productInAreaModelFromMap(jsonString);

import 'dart:convert';

class ProductInAreaModel {
  ProductInAreaModel({
    this.result,
  });

  List<Result> result;

  factory ProductInAreaModel.fromJson(String str) =>
      ProductInAreaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductInAreaModel.fromMap(Map<String, dynamic> json) =>
      ProductInAreaModel(
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.productId,
    this.productName,
    this.productImage,
    this.productPrice,
    this.matsSpclPrice,
    this.percentageSaved,
    this.distanceInKm,
  });

  int productId;
  String productName;
  String productImage;
  num productPrice;
  num matsSpclPrice;
  int percentageSaved;
  int distanceInKm;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        productId: json["Product_ID"],
        productName: json["Product_Name"],
        productImage: json["Product_Image"],
        productPrice: json["Product_Price"],
        matsSpclPrice: json["MatsSpclPrice"],
        percentageSaved: json["Percentage_saved"],
        distanceInKm: json["DistanceInKM"],
      );

  Map<String, dynamic> toMap() => {
        "Product_ID": productId,
        "Product_Name": productName,
        "Product_Image": productImage,
        "Product_Price": productPrice,
        "MatsSpclPrice": matsSpclPrice,
        "Percentage_saved": percentageSaved,
        "DistanceInKM": distanceInKm,
      };
}
