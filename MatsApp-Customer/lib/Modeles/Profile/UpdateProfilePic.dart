// To parse this JSON data, do
//
//     final updateProfilePic = updateProfilePicFromMap(jsonString);

import 'dart:convert';

class UpdateProfilePic {
  UpdateProfilePic({
    this.result,
  });

  int result;

  factory UpdateProfilePic.fromJson(String str) =>
      UpdateProfilePic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateProfilePic.fromMap(Map<String, dynamic> json) =>
      UpdateProfilePic(
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
      };
}
