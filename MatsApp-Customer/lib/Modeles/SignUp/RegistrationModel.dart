// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromMap(jsonString);

import 'dart:convert';

class RegistrationModel {
  RegistrationModel({
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
    this.accName,
    this.accEmail,
    this.accGender,
    this.accDob,
    this.accProfession,
    this.accProfilePhotoUrl,
    this.accDevicetoken,
    this.accStatus,
    this.accOtp,
    this.accApiKey,
  });

  int accId;
  String accMobile;
  String accPassword;
  dynamic accReferralCode;
  int accVerified;
  String accState;
  String accDistrict;
  String accTown;
  String accCreatedDate;
  dynamic accLastLogin;
  dynamic accName;
  dynamic accEmail;
  dynamic accGender;
  dynamic accDob;
  dynamic accProfession;
  dynamic accProfilePhotoUrl;
  String accDevicetoken;
  int accStatus;
  dynamic accOtp;
  dynamic accApiKey;

  factory RegistrationModel.fromJson(String str) =>
      RegistrationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegistrationModel.fromMap(Map<String, dynamic> json) =>
      RegistrationModel(
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
        accName: json["Acc_Name"],
        accEmail: json["Acc_Email"],
        accGender: json["Acc_Gender"],
        accDob: json["Acc_DOB"],
        accProfession: json["Acc_Profession"],
        accProfilePhotoUrl: json["Acc_ProfilePhotoUrl"],
        accDevicetoken: json["Acc_Devicetoken"],
        accStatus: json["Acc_Status"],
        accOtp: json["Acc_OTP"],
        accApiKey: json["Acc_apiKey"],
      );

  Map<String, dynamic> toMap() => {
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
        "Acc_Name": accName,
        "Acc_Email": accEmail,
        "Acc_Gender": accGender,
        "Acc_DOB": accDob,
        "Acc_Profession": accProfession,
        "Acc_ProfilePhotoUrl": accProfilePhotoUrl,
        "Acc_Devicetoken": accDevicetoken,
        "Acc_Status": accStatus,
        "Acc_OTP": accOtp,
        "Acc_apiKey": accApiKey,
      };
}
