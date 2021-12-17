import 'package:matsapp/utilities/app_json_parser.dart';

class CouponModel {
  String couponId;
  String couponTitle;
  int businessId;
  String businessName;
  int productId;
  dynamic productName;
  int purchased;
  int downloads;
  int gift;
  double matsappDiscount;
  String couponExpiryDate;
  double purchaseLimit;
  double purchaseValue;
  String termsAndConditions;
  String logoUrl;
  String status;
  double couponValue;
  double maximumDenomination;
  String couponType;
  String type;
  double yourSavings;
  String shareFlag;
  String couponFrom;
  String levelImage;
  String levelName;
  String giftName;

  int uCID;

  double save;
  double calculatedPurchaseLimit;
  String ucId;
  String userCouponId;

  CouponModel.fromJsonMap(Map<String, dynamic> json) {
    couponId = AppJsonParser.goodString(json, "CouponID");
    couponTitle = AppJsonParser.goodString(json, "CouponTitle");
    couponValue = AppJsonParser.goodDouble(json, "CouponValue");
    businessId = AppJsonParser.goodInt(json, "BusinessID");
    businessName = AppJsonParser.goodString(json, "BusinessName");
    productId = AppJsonParser.goodInt(json, "ProductID");
    productName = AppJsonParser.goodString(json, "ProductName");
    purchased = AppJsonParser.goodInt(json, "Purchased");
    downloads = AppJsonParser.goodInt(json, "Downloads");
    gift = AppJsonParser.goodHexInt(json, "Gift");
    matsappDiscount = AppJsonParser.goodDouble(json, "MatsappDiscount");
    couponExpiryDate = AppJsonParser.goodString(json, "CouponExpiryDate");
    purchaseLimit = AppJsonParser.goodDouble(json, "PurchaseLimit");
    purchaseValue = AppJsonParser.goodDouble(json, "PurchaseValue") ;
    termsAndConditions = AppJsonParser.goodString(json, "TermsandConditions");
    logoUrl = AppJsonParser.goodString(json, "LogoUrl");
    status = AppJsonParser.goodString(json, "Status");
    ucId = AppJsonParser.goodString(json, "UC_ID");
    userCouponId = AppJsonParser.goodString(json, "UserCouponID");
    couponType = AppJsonParser.goodString(json, "CouponType");
    maximumDenomination = AppJsonParser.goodDouble(json, "MaximumDenomination");
    type = AppJsonParser.goodString(json, "Type");
    uCID = AppJsonParser.goodInt(json, "UC_ID");
    yourSavings = AppJsonParser.goodDouble(json, "YourSavings");
    shareFlag = AppJsonParser.goodString(json, "ShareFlag");
    couponFrom = AppJsonParser.goodString(json, "CouponFrom");

    levelImage = AppJsonParser.goodString(json, "LevelImage");
    levelName = AppJsonParser.goodString(json, "LevelName");
    giftName = AppJsonParser.goodString(json, "GiftName");

    // if (couponValue != null && purchaseValue != null)
    //   save = couponValue - purchaseValue;
    // if (purchaseLimit != null && couponValue != null && matsappDiscount != null)
    //   calculatedPurchaseLimit = couponValue * 100 / matsappDiscount;
  }

  bool get hasTermsAndCondition => termsAndConditions?.isNotEmpty ?? false;
}
