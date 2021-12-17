// To parse this JSON data, do
//
//     final townModel = townModelFromMap(jsonString);

import 'dart:convert';

class TownModel {
  TownModel({
    this.result,
  });

  List<TownItem> result;

  factory TownModel.fromJson(String str) => TownModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TownModel.fromMap(Map<String, dynamic> json) => TownModel(
        result:
            List<TownItem>.from(json["result"].map((x) => TownItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class TownItem {
  TownItem({
    this.pkTown,
    this.town,
    this.fkState,
    this.fkDistrict,
  });

  String pkTown;
  String town;

  FkState fkState;
  FkDistrict fkDistrict;

  factory TownItem.fromJson(String str) => TownItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TownItem.fromMap(Map<String, dynamic> json) => TownItem(
        pkTown: json["PK_Town"],
        town: json["Town"],
        fkState: fkStateValues.map[json["FK_State"]],
        fkDistrict: fkDistrictValues.map[json["FK_District"]],
      );

  Map<String, dynamic> toMap() => {
        "PK_Town": pkTown,
        "Town": town,
        "FK_State": fkStateValues.reverse[fkState],
        "FK_District": fkDistrictValues.reverse[fkDistrict],
      };
}

enum FkDistrict { THRISSUR }

final fkDistrictValues = EnumValues({"Thrissur": FkDistrict.THRISSUR});

enum FkState { KERALA }

final fkStateValues = EnumValues({"Kerala": FkState.KERALA});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
