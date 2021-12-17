// To parse this JSON data, do
//
//     final completeRegistrationModel = completeRegistrationModelFromMap(jsonString);

import 'dart:convert';

CompleteRegistrationModel completeRegistrationModelFromMap(String str) =>
    CompleteRegistrationModel.fromMap(json.decode(str));

String completeRegistrationModelToMap(CompleteRegistrationModel data) =>
    json.encode(data.toMap());

class CompleteRegistrationModel {
  CompleteRegistrationModel({
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
    this.accSubTown,
    this.usertype,
    this.townName,
  });

  int accId;
  String accMobile;
  String accPassword;
  String accReferralCode;
  int accVerified;
  String accState;
  String accDistrict;
  String accTown;
  String accCreatedDate;
  String accLastLogin;
  String accName;
  String accEmail;
  dynamic accGender;
  dynamic accDob;
  dynamic accProfession;
  String accProfilePhotoUrl;
  String accDevicetoken;
  int accStatus;
  String accOtp;
  String accApiKey;
  String accSubTown;
  String usertype;
  String townName;

  factory CompleteRegistrationModel.fromMap(Map<String, dynamic> json) =>
      CompleteRegistrationModel(
        accId: json["Acc_ID"] == null ? null : json["Acc_ID"],
        accMobile: json["Acc_Mobile"] == null ? null : json["Acc_Mobile"],
        accPassword: json["Acc_Password"] == null ? null : json["Acc_Password"],
        accReferralCode:
            json["Acc_ReferralCode"] == null ? null : json["Acc_ReferralCode"],
        accVerified: json["Acc_Verified"] == null ? null : json["Acc_Verified"],
        accState: json["Acc_state"] == null ? null : json["Acc_state"],
        accDistrict: json["Acc_District"] == null ? null : json["Acc_District"],
        accTown: json["Acc_Town"] == null ? null : json["Acc_Town"],
        accCreatedDate:
            json["Acc_CreatedDate"] == null ? null : json["Acc_CreatedDate"],
        accLastLogin:
            json["Acc_LastLogin"] == null ? null : json["Acc_LastLogin"],
        accName: json["Acc_Name"] == null ? null : json["Acc_Name"],
        accEmail: json["Acc_Email"] == null ? null : json["Acc_Email"],
        accGender: json["Acc_Gender"],
        accDob: json["Acc_DOB"],
        accProfession: json["Acc_Profession"],
        accProfilePhotoUrl: json["Acc_ProfilePhotoUrl"] == null
            ? null
            : json["Acc_ProfilePhotoUrl"],
        accDevicetoken:
            json["Acc_Devicetoken"] == null ? null : json["Acc_Devicetoken"],
        accStatus: json["Acc_Status"] == null ? null : json["Acc_Status"],
        accOtp: json["Acc_OTP"] == null ? null : json["Acc_OTP"],
        accApiKey: json["Acc_apiKey"] == null ? null : json["Acc_apiKey"],
        accSubTown: json["Acc_SubTown"] == null ? null : json["Acc_SubTown"],
        usertype: json["usertype"] == null ? null : json["usertype"],
        townName: json["townName"] == null ? null : json["townName"],
      );

  Map<String, dynamic> toMap() => {
        "Acc_ID": accId == null ? null : accId,
        "Acc_Mobile": accMobile == null ? null : accMobile,
        "Acc_Password": accPassword == null ? null : accPassword,
        "Acc_ReferralCode": accReferralCode == null ? null : accReferralCode,
        "Acc_Verified": accVerified == null ? null : accVerified,
        "Acc_state": accState == null ? null : accState,
        "Acc_District": accDistrict == null ? null : accDistrict,
        "Acc_Town": accTown == null ? null : accTown,
        "Acc_CreatedDate": accCreatedDate == null ? null : accCreatedDate,
        "Acc_LastLogin": accLastLogin == null ? null : accLastLogin,
        "Acc_Name": accName == null ? null : accName,
        "Acc_Email": accEmail == null ? null : accEmail,
        "Acc_Gender": accGender,
        "Acc_DOB": accDob,
        "Acc_Profession": accProfession,
        "Acc_ProfilePhotoUrl":
            accProfilePhotoUrl == null ? null : accProfilePhotoUrl,
        "Acc_Devicetoken": accDevicetoken == null ? null : accDevicetoken,
        "Acc_Status": accStatus == null ? null : accStatus,
        "Acc_OTP": accOtp == null ? null : accOtp,
        "Acc_apiKey": accApiKey == null ? null : accApiKey,
        "Acc_SubTown": accSubTown == null ? null : accSubTown,
        "usertype": usertype == null ? null : usertype,
        "townName": townName == null ? null : townName,
      };
}
