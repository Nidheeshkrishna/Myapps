// To parse this JSON data, do
//
//     final luckyDrawModel = luckyDrawModelFromMap(jsonString);

import 'dart:convert';

class LuckyDrawModel {
  LuckyDrawModel({
    this.result1,
    this.result2,
  });

  List<Result1> result1;
  Result2 result2;

  factory LuckyDrawModel.fromJson(String str) =>
      LuckyDrawModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LuckyDrawModel.fromMap(Map<String, dynamic> json) => LuckyDrawModel(
        result1: json["result1"] == null
            ? null
            : List<Result1>.from(
                json["result1"].map((x) => Result1.fromMap(x))),
        result2:
            json["result2"] == null ? null : Result2.fromMap(json["result2"]),
      );

  Map<String, dynamic> toMap() => {
        "result1": result1 == null
            ? null
            : List<dynamic>.from(result1.map((x) => x.toMap())),
        "result2": result2 == null ? null : result2.toMap(),
      };
}

class Result1 {
  Result1({
    this.id,
    this.userMobile,
    this.ticketNo,
    this.assignedDate,
    this.title,
    this.description,
    this.logoUrl,
    this.status,
  });

  String id;
  String userMobile;
  String ticketNo;
  String assignedDate;
  String title;
  String description;
  String logoUrl;
  String status;

  factory Result1.fromJson(String str) => Result1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result1.fromMap(Map<String, dynamic> json) => Result1(
        id: json["ID"] == null ? null : json["ID"],
        userMobile: json["UserMobile"] == null ? null : json["UserMobile"],
        ticketNo: json["TicketNo"] == null ? null : json["TicketNo"],
        assignedDate:
            json["Assigned_Date"] == null ? null : json["Assigned_Date"],
        title: json["Title"] == null ? null : json["Title"],
        description: json["Description"] == null ? null : json["Description"],
        logoUrl: json["LogoUrl"] == null ? null : json["LogoUrl"],
        status: json["Status"] == null ? null : json["Status"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id == null ? null : id,
        "UserMobile": userMobile == null ? null : userMobile,
        "TicketNo": ticketNo == null ? null : ticketNo,
        "Assigned_Date": assignedDate == null ? null : assignedDate,
        "Title": title == null ? null : title,
        "Description": description == null ? null : description,
        "LogoUrl": logoUrl == null ? null : logoUrl,
        "Status": logoUrl == null ? null : status,
      };
}

class Result2 {
  Result2({
    this.ticketCount,
    this.wonTicketCount,
  });

  String ticketCount;
  String wonTicketCount;

  factory Result2.fromJson(String str) => Result2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result2.fromMap(Map<String, dynamic> json) => Result2(
        ticketCount: json["TicketCount"] == null ? null : json["TicketCount"],
        wonTicketCount:
            json["WonTicketCount"] == null ? null : json["WonTicketCount"],
      );

  Map<String, dynamic> toMap() => {
        "TicketCount": ticketCount == null ? null : ticketCount,
        "WonTicketCount": wonTicketCount == null ? null : wonTicketCount,
      };
}
