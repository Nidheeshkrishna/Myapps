// To parse this JSON data, do
//
//     final surpriseGiftModel = surpriseGiftModelFromMap(jsonString);

import 'dart:convert';

class SurpriseGiftModel {
    SurpriseGiftModel({
        this.businessGiftData,
        this.levelData,
        this.apiKeyStatus,
    });

    BusinessGiftData businessGiftData;
    List<LevelDatum> levelData;
    bool apiKeyStatus;

    factory SurpriseGiftModel.fromJson(String str) => SurpriseGiftModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SurpriseGiftModel.fromMap(Map<String, dynamic> json) => SurpriseGiftModel(
        businessGiftData: BusinessGiftData.fromMap(json["BusinessGiftData"]),
        levelData: List<LevelDatum>.from(json["LevelData"].map((x) => LevelDatum.fromMap(x))),
        apiKeyStatus: json["ApiKey_status"],
    );

    Map<String, dynamic> toMap() => {
        "BusinessGiftData": businessGiftData.toMap(),
        "LevelData": List<dynamic>.from(levelData.map((x) => x.toMap())),
        "ApiKey_status": apiKeyStatus,
    };
}

class BusinessGiftData {
    BusinessGiftData({
        this.giftName,
        this.giftImage,
        this.giftDescription,
        this.termsCondition,
    });

    String giftName;
    String giftImage;
    String giftDescription;
    String termsCondition;

    factory BusinessGiftData.fromJson(String str) => BusinessGiftData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BusinessGiftData.fromMap(Map<String, dynamic> json) => BusinessGiftData(
        giftName: json["GiftName"],
        giftImage: json["GiftImage"],
        giftDescription: json["GiftDescription"],
        termsCondition: json["TermsCondition"],
    );

    Map<String, dynamic> toMap() => {
        "GiftName": giftName,
        "GiftImage": giftImage,
        "GiftDescription": giftDescription,
        "TermsCondition": termsCondition,
    };
}

class LevelDatum {
    LevelDatum({
        this.levelName,
        this.levelImage,
    });

    String levelName;
    String levelImage;

    factory LevelDatum.fromJson(String str) => LevelDatum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LevelDatum.fromMap(Map<String, dynamic> json) => LevelDatum(
        levelName: json["LevelName"],
        levelImage: json["LevelImage"],
    );

    Map<String, dynamic> toMap() => {
        "LevelName": levelName,
        "LevelImage": levelImage,
    };
}
