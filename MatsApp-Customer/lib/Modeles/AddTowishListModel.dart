// To parse this JSON data, do
//
//     final addTowishListModel = addTowishListModelFromMap(jsonString);

import 'dart:convert';

class AddTowishListModel {
  AddTowishListModel({
    this.result,
  });

  int result;

  factory AddTowishListModel.fromJson(String str) =>
      AddTowishListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddTowishListModel.fromMap(Map<String, dynamic> json) =>
      AddTowishListModel(
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
      };
}
