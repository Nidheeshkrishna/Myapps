// To parse this JSON data, do
//
//     final getSubTownsModel = getSubTownsModelFromMap(jsonString);

import 'dart:convert';

class GetSubTownsModel {
  GetSubTownsModel({
    this.result,
  });

  List<SubtownTownItem> result;

  factory GetSubTownsModel.fromJson(String str) =>
      GetSubTownsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSubTownsModel.fromMap(Map<String, dynamic> json) =>
      GetSubTownsModel(
        result: List<SubtownTownItem>.from(
            json["result"].map((x) => SubtownTownItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.pkTown,
    this.stId,
    this.stTwId,
    this.stSubTown,
  });

  dynamic pkTown;
  String stId;
  String stTwId;
  String stSubTown;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        pkTown: json["PK_Town"],
        stId: json["ST_ID"],
        stTwId: json["ST_TW_ID"],
        stSubTown: json["ST_SubTown"],
      );

  Map<String, dynamic> toMap() => {
        "PK_Town": pkTown,
        "ST_ID": stId,
        "ST_TW_ID": stTwId,
        "ST_SubTown": stSubTown,
      };
}

class SubtownTownItem {
  SubtownTownItem({
    this.pkTown,
    this.stId,
    this.stTwId,
    this.stSubTown,
  });

  String pkTown;
  String stId;
  String stTwId;
  String stSubTown;

  factory SubtownTownItem.fromJson(String str) =>
      SubtownTownItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubtownTownItem.fromMap(Map<String, dynamic> json) => SubtownTownItem(
        pkTown: json["PK_Town"],
        stId: json["ST_ID"],
        stTwId: json["ST_TW_ID"],
        stSubTown: json["ST_SubTown"],
      );

  Map<String, dynamic> toMap() => {
        "PK_Town": pkTown,
        "ST_ID": stId,
        "ST_TW_ID": stTwId,
        "ST_SubTown": stSubTown,
      };
}
