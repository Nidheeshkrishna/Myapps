// To parse this JSON data, do
//
//     final appUpdateModel = appUpdateModelFromMap(jsonString);

import 'dart:convert';

class AppUpdateModel {
  AppUpdateModel({
    this.updateavailable,
    this.mustupdate,
  });

  bool updateavailable;
  bool mustupdate;

  factory AppUpdateModel.fromJson(String str) =>
      AppUpdateModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppUpdateModel.fromMap(Map<String, dynamic> json) => AppUpdateModel(
        updateavailable: json["updateavailable"],
        mustupdate: json["mustupdate"],
      );

  Map<String, dynamic> toMap() => {
        "updateavailable": updateavailable,
        "mustupdate": mustupdate,
      };
}
