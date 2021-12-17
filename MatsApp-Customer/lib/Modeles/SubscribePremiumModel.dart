// To parse this JSON data, do
//
//     final subscribePremiumModel = subscribePremiumModelFromMap(jsonString);

import 'dart:convert';

class SubscribePremiumModel {
  SubscribePremiumModel({
    this.result,  
  });

  int result;

  factory SubscribePremiumModel.fromJson(String str) =>
      SubscribePremiumModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubscribePremiumModel.fromMap(Map<String, dynamic> json) =>
      SubscribePremiumModel(
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
      };
}
