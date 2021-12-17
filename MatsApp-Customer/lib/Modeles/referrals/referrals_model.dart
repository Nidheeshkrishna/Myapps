import 'package:matsapp/utilities/app_json_parser.dart';

class ReferralsModel {
  String referralCode;
  int totalReferrals;
  double earnedCoins;
  String amount;
  bool anyReferenceLeft;
  bool claimAllow;

  ReferralsModel();

  ReferralsModel.fromJson(Map<String, dynamic> json) {
    referralCode = AppJsonParser.goodString(json, "RefferalCode");
    totalReferrals = AppJsonParser.goodInt(json, "TotalReferrals");
    earnedCoins = AppJsonParser.goodDouble(json, "EarnedCoins");
    amount = AppJsonParser.goodString(json, "Amount");
    anyReferenceLeft = AppJsonParser.goodBoolean(json, "HasReference");
    claimAllow = AppJsonParser.goodBoolean(json, "ClaimAllow");
  }
}
