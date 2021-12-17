// To parse this JSON data, do
//
//     final getSuggestionsModel = getSuggestionsModelFromMap(jsonString);

import 'dart:convert';

class GetSuggestionsModel {
    GetSuggestionsModel({
        this.result,
        this.apiKeyStatus,
    });

    List<String> result;
    bool apiKeyStatus;

    factory GetSuggestionsModel.fromJson(String str) => GetSuggestionsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetSuggestionsModel.fromMap(Map<String, dynamic> json) => GetSuggestionsModel(
        result: json["Result"] == null ? null : List<String>.from(json["Result"].map((x) => x)),
        apiKeyStatus: json["ApiKey_status"] == null ? null : json["ApiKey_status"],
    );

    Map<String, dynamic> toMap() => {
        "Result": result == null ? null : List<dynamic>.from(result.map((x) => x)),
        "ApiKey_status": apiKeyStatus == null ? null : apiKeyStatus,
    };
}
