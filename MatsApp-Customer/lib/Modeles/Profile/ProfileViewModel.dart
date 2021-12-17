// To parse this JSON data, do
//
//     final profileViewModel = profileViewModelFromMap(jsonString);

import 'dart:convert';

class ProfileViewModel {
  ProfileViewModel({
    this.result,
  });

  List<Result> result;

  factory ProfileViewModel.fromJson(String str) =>
      ProfileViewModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileViewModel.fromMap(Map<String, dynamic> json) =>
      ProfileViewModel(
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.name,
    this.district,
    this.state,
    this.walletAmount,
    this.savingsAmount,
    this.referralAmount,
    this.gender,
    this.dob,
    this.profession,
    this.email,
    this.imageUrl,
  });

  String name;
  String district;
  String state;
  String walletAmount;
  String savingsAmount;
  String referralAmount;
  String gender;
  String dob;
  String profession;
  String email;
  String imageUrl;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        name: json["Name"],
        district: json["District"],
        state: json["State"],
        walletAmount: json["WalletAmount"],
        savingsAmount: json["SavingsAmount"],
        referralAmount: json["ReferralAmount"],
        gender: json["Gender"],
        dob: json["DOB"],
        profession: json["Profession"],
        email: json["Email"],
        imageUrl: json["ImageURL"],
      );

  Map<String, dynamic> toMap() => {
        "Name": name,
        "District": district,
        "State": state,
        "WalletAmount": walletAmount,
        "SavingsAmount": savingsAmount,
        "ReferralAmount": referralAmount,
        "Gender": gender,
        "DOB": dob,
        "Profession": profession,
        "Email": email,
        "ImageURL": imageUrl,
      };
}
