// To parse this JSON data, do
//
//     final ratingModel = ratingModelFromMap(jsonString);

import 'dart:convert';

class RatingModel {
  RatingModel({
    this.result,
  });

  int result;

  factory RatingModel.fromJson(String str) =>
      RatingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RatingModel.fromMap(Map<String, dynamic> json) => RatingModel(
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
      };
}
