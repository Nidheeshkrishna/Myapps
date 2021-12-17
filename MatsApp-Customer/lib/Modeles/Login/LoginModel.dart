// To parse this JSON data, do
//
//     final loginModel = loginModelFromMap(jsonString);

import 'dart:convert';

class LoginModel {
  LoginModel({
    this.accApiKey,
    this.accId,
    this.accMobile,
    this.accPassword,
    this.accReferralCode,
    this.accVerified,
    this.accState,
    this.accDistrict,
    this.accTown,
    this.accCreatedDate,
    this.accLastLogin,
    this.status,
    this.accDevicetoken,
    this.userType,
    this.accSubTown,
    this.districtName,
    this.townName,
    this.subTownName,
    this.premiumUser,
  });

  String accApiKey;
  int accId;
  String accMobile;
  String accPassword;
  dynamic accReferralCode;
  int accVerified;
  String accState;
  String accDistrict;
  String accTown;
  String accCreatedDate;
  String accLastLogin;
  int status;
  String accDevicetoken;
  String userType;
  String accSubTown;
  String districtName;
  String townName;
  String subTownName;
  bool premiumUser;

  factory LoginModel.fromJson(String str) =>
      LoginModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
      accApiKey: json["Acc_apiKey"],
      accId: json["Acc_ID"],
      accMobile: json["Acc_Mobile"],
      accPassword: json["Acc_Password"],
      accReferralCode: json["Acc_ReferralCode"],
      accVerified: json["Acc_Verified"],
      accState: json["Acc_state"],
      accDistrict: json["Acc_District"],
      accTown: json["Acc_Town"],
      accCreatedDate: json["Acc_CreatedDate"],
      accLastLogin: json["Acc_LastLogin"],
      status: json["Status"],
      accDevicetoken: json["Acc_Devicetoken"],
      userType: json["UserType"],
      accSubTown: json["Acc_SubTown"],
      districtName: json["DistrictName"],
      townName: json["TownName"],
      subTownName: json["SubTownName"],
      premiumUser: json["PremiumUser"]);

  Map<String, dynamic> toMap() => {
        "Acc_apiKey": accApiKey,
        "Acc_ID": accId,
        "Acc_Mobile": accMobile,
        "Acc_Password": accPassword,
        "Acc_ReferralCode": accReferralCode,
        "Acc_Verified": accVerified,
        "Acc_state": accState,
        "Acc_District": accDistrict,
        "Acc_Town": accTown,
        "Acc_CreatedDate": accCreatedDate,
        "Acc_LastLogin": accLastLogin,
        "Status": status,
        "Acc_Devicetoken": accDevicetoken,
        "UserType": userType,
        "Acc_SubTown": accSubTown,
        "DistrictName": districtName,
        "TownName": townName,
        "SubTownName": subTownName,
        "PremiumUser": premiumUser
      };
}
