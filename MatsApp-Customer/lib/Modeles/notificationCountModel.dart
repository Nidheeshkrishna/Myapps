// To parse this JSON data, do
//
//     final notificationCountModel = notificationCountModelFromMap(jsonString);

import 'dart:convert';

class NotificationCountModel {
    NotificationCountModel({
        this.result,
        this.apiKeyStatus,
    });

    int result;
    bool apiKeyStatus;

    factory NotificationCountModel.fromJson(String str) => NotificationCountModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NotificationCountModel.fromMap(Map<String, dynamic> json) => NotificationCountModel(
        result: json["result"],
        apiKeyStatus: json["ApiKey_status"],
    );

    Map<String, dynamic> toMap() => {
        "result": result,
        "ApiKey_status": apiKeyStatus,
    };
}
