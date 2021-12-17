// To parse this JSON data, do
//
//     final districtModel = districtModelFromMap(jsonString);

import 'dart:convert';

class DistrictModel {
  DistrictModel({
    this.result,
    
  });

  List<DistrictItem> result;

  factory DistrictModel.fromJson(String str) =>
      DistrictModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DistrictModel.fromMap(Map<String, dynamic> json) => DistrictModel(
        result: List<DistrictItem>.from(json["result"].map((x) => DistrictItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class DistrictItem {
  DistrictItem({
    this.disPkDistrict,
    this.district,
  });

  String disPkDistrict;
  String district;

  factory DistrictItem.fromJson(String str) => DistrictItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DistrictItem.fromMap(Map<String, dynamic> json) => DistrictItem(
        disPkDistrict: json["Dis_PK_District"],
        district: json["District"],
      );

  Map<String, dynamic> toMap() => {
        "Dis_PK_District": disPkDistrict,
        "District": district,
      };
}
