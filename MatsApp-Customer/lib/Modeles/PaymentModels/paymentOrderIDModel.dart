// To parse this JSON data, do
//
//     final paymentOrderIdModel = paymentOrderIdModelFromMap(jsonString);

import 'dart:convert';

class PaymentOrderIdModel {
  PaymentOrderIdModel({
    this.result,
  });

  Result result;

  factory PaymentOrderIdModel.fromJson(String str) =>
      PaymentOrderIdModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentOrderIdModel.fromMap(Map<String, dynamic> json) =>
      PaymentOrderIdModel(
        result: Result.fromMap(json["result"]),
      );

  Map<String, dynamic> toMap() => {
        "result": result.toMap(),
      };
}

class Result {
  Result({this.ucId, this.status, this.purchaseAmount});

  int ucId;
  String status;
  double purchaseAmount;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        ucId: json["UC_ID"],
        status: json["Status"],
        purchaseAmount: json["PurchaseAmount"],
      );

  Map<String, dynamic> toMap() =>
      {"UC_ID": ucId, "Status": status, "PurchaseAmount": purchaseAmount};
}
