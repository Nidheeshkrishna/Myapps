import 'dart:convert';

class OtpVerifiyModel {
  OtpVerifiyModel({
    this.status,
  });

  String status;

  factory OtpVerifiyModel.fromJson(String str) =>
      OtpVerifiyModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtpVerifiyModel.fromMap(Map<String, dynamic> json) => OtpVerifiyModel(
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
      };
}
