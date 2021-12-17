// To parse this JSON data, do
//
//     final profilepageModel = profilepageModelFromMap(jsonString);

import 'dart:convert';

class ProfilepageEditModel {
  ProfilepageEditModel({
    this.result,
  });

  bool result;

  factory ProfilepageEditModel.fromJson(String str) =>
      ProfilepageEditModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfilepageEditModel.fromMap(Map<String, dynamic> json) =>
      ProfilepageEditModel(
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
      };
}
