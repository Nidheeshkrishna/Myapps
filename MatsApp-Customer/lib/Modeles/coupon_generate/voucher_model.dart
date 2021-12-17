import 'package:matsapp/utilities/app_json_parser.dart';

class VoucherModel {
  String id;
  String name;
  int businessId;
  String businessName;
  double voucherValue;
  String expiryDate;
  String tc;
  String logoUrl;
  String productName;
  String ucId;
  String userVoucherId;

  String shareFlag;
  double purchaseLimit;
  double yourSavings;

  VoucherModel.fromJson(Map<String, dynamic> json) {
    id = AppJsonParser.goodString(json, 'ID');
    name = AppJsonParser.goodString(json, 'NAME');
    businessId = AppJsonParser.goodInt(json, 'BusinessID');
    businessName = AppJsonParser.goodString(json, 'BusinessName');
    voucherValue = AppJsonParser.goodDouble(json, 'VoucherValue');
    expiryDate = AppJsonParser.goodString(json, 'ExpiryDate');
    tc = AppJsonParser.goodString(json, 'TermsandConditions');
    logoUrl = AppJsonParser.goodString(json, 'LogoUrl');
    productName = AppJsonParser.goodString(json, 'ProductName');
    ucId = AppJsonParser.goodString(json, "UC_ID");
    userVoucherId = AppJsonParser.goodString(json, "UserVoucherID");

    shareFlag = AppJsonParser.goodString(json, "ShareFlag");
    purchaseLimit = AppJsonParser.goodDouble(json, "PurchaseLimit");
    yourSavings = AppJsonParser.goodDouble(json, "YourSavings");
  }
}
