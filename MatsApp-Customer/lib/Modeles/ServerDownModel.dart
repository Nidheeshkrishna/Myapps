// To parse this JSON data, do
//
//     final serverDownModel = serverDownModelFromMap(jsonString);

import 'dart:convert';

class ServerDownModel {
    ServerDownModel({
        this.result,
        this.apiKeyStatus,
    });

    Result result;
    bool apiKeyStatus;

    factory ServerDownModel.fromJson(String str) => ServerDownModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ServerDownModel.fromMap(Map<String, dynamic> json) => ServerDownModel(
        result: json["result"] == null ? null : Result.fromMap(json["result"]),
        apiKeyStatus: json["ApiKey_status"] == null ? null : json["ApiKey_status"],
    );

    Map<String, dynamic> toMap() => {
        "result": result == null ? null : result.toMap(),
        "ApiKey_status": apiKeyStatus == null ? null : apiKeyStatus,
    };
}

class Result {
    Result({
        this.message,
        this.maintenance,
    });

    String message;
    bool maintenance;

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        message: json["Message"] == null ? null : json["Message"],
        maintenance: json["Maintenance"] == null ? null : json["Maintenance"],
    );

    Map<String, dynamic> toMap() => {
        "Message": message == null ? null : message,
        "Maintenance": maintenance == null ? null : maintenance,
    };
}
