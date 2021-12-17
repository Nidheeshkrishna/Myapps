import 'package:flutter/cupertino.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Modeles/coupon_generate/result_model.dart';
import 'package:matsapp/services/base_service.dart';
import 'package:matsapp/utilities/app_json_parser.dart';

class CouponGenerateRepository extends BaseService {
  static CouponGenerateRepository _instance = CouponGenerateRepository._();

  CouponGenerateRepository._() : super();

  factory CouponGenerateRepository() {
    return _instance;
  }

  Future<void> getCouponDetails({
    onSuccess<CouponModel> onSuccess,
    onFailure failure,
    String couponId,
    String type,
  }) async {
    String town = await getSelectedTown();

    var params = {
      "CouponID": "$couponId",
      "CouponType": "${type ?? "Product"}",
      "Town": town,
    };
    getService(
        service: "GetInfoForGenerateCoupon",
        params: params,
        onException: failure,
        onSuccess: (response) {
          CouponModel coupon = AppJsonParser.goodList(response, "result")
              .map((e) => CouponModel.fromJsonMap(e))
              ?.first;
          onSuccess(coupon);
        });
  }

  Future<void> buyCoupon({
    @required CouponModel coupon,
    @required int multiplier,
    onSuccess<ResultModel> onSuccess,
    onFailure failure,
  }) async {
    String mobileNo = await getMobileNo();
    int userId = await getUserId();
    String apiKey = await getApiKey;

    var params = {
      "CouponID": "${coupon.couponId}",
      "PurchaseAmount": coupon.purchaseValue,
      "CouponDenomination": coupon.couponValue,
      "PurchaseLimit": coupon.purchaseLimit,
      "count": multiplier,
      "mobile": mobileNo,
      'UserID': userId,
      "CouponType": "Store",
      "api_key": apiKey,
    };
    postService(
        service: "GenerateCoupons",
        params: params,
        onException: failure,
        onSuccess: (response) {
          ResultModel result = ResultModel.fromJson(response);

          onSuccess(result);
        });
  }
}
