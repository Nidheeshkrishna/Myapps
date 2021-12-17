

// To parse this JSON data, do
//
//     final coupounCancel = coupounCancelFromMap(jsonString);

import 'dart:convert';

class CoupounCancel {
    CoupounCancel({
        this.result,
    });

    String result;

    factory CoupounCancel.fromJson(String str) => CoupounCancel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CoupounCancel.fromMap(Map<String, dynamic> json) => CoupounCancel(
        result: json["result"],
    );

    Map<String, dynamic> toMap() => {
        "result": result,
    };
}

