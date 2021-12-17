// To parse this JSON data, do
//
//     final townVerifiyModel = townVerifiyModelFromMap(jsonString);

import 'dart:convert';

TownVerifiyModel townVerifiyModelFromMap(String str) =>
    TownVerifiyModel.fromMap(json.decode(str));

String townVerifiyModelToMap(TownVerifiyModel data) =>
    json.encode(data.toMap());

class TownVerifiyModel {
  TownVerifiyModel({
    this.result,
    this.apiKeyStatus,
  });

  Result result;
  bool apiKeyStatus;

  factory TownVerifiyModel.fromMap(Map<String, dynamic> json) =>
      TownVerifiyModel(
        result: json["Result"] == null ? null : Result.fromMap(json["Result"]),
        apiKeyStatus:
            json["ApiKey_status"] == null ? null : json["ApiKey_status"],
      );

  Map<String, dynamic> toMap() => {
        "Result": result == null ? null : result.toMap(),
        "ApiKey_status": apiKeyStatus == null ? null : apiKeyStatus,
      };
}

class Result {
  Result({
    this.townStatus,
    this.districtStatus,
  });

  bool townStatus;
  bool districtStatus;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        townStatus: json["townStatus"] == null ? null : json["townStatus"],
        districtStatus:
            json["districtStatus"] == null ? null : json["districtStatus"],
      );

  Map<String, dynamic> toMap() => {
        "townStatus": townStatus == null ? null : townStatus,
        "districtStatus": districtStatus == null ? null : districtStatus,
      };
}
