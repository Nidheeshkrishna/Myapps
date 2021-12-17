// To parse this JSON data, do
//
//     final removeTowishListModel = removeTowishListModelFromMap(jsonString);

import 'dart:convert';

class RemoveTowishListModel {
  RemoveTowishListModel({
    this.result,
  });

  int result;

  factory RemoveTowishListModel.fromJson(String str) =>
      RemoveTowishListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RemoveTowishListModel.fromMap(Map<String, dynamic> json) =>
      RemoveTowishListModel(
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
      };
}
