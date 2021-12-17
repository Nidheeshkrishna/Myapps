// To parse this JSON data, do
//
//     final paymentOrderIdModel = paymentOrderIdModelFromMap(jsonString);

import 'dart:convert';

class PaymentScccessModel {
  PaymentScccessModel({
    this.result,
  });

  String result;

  factory PaymentScccessModel.fromJson(String str) =>
      PaymentScccessModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentScccessModel.fromMap(Map<String, dynamic> json) =>
      PaymentScccessModel(
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
      };
}
