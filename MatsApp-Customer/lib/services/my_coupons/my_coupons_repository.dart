import 'package:flutter/cupertino.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Modeles/coupon_generate/result_model.dart';
import 'package:matsapp/Modeles/coupon_generate/voucher_model.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/services/app_exceptions.dart';
import 'package:matsapp/utilities/app_extensions.dart';
import 'package:matsapp/utilities/app_json_parser.dart';

import '../base_service.dart';

class MyCouponRepository extends BaseService {
  static MyCouponRepository _instance = MyCouponRepository._();

  MyCouponRepository._() : super();

  factory MyCouponRepository() {
    return _instance;
  }

  Future<void> getCoupon({
    @required COUPON_TYPES coupon,
    String voucherId,
    onSuccess<List<CouponModel>> onSuccess,
    onFailure failure,
  }) async {
    int userId = await getUserId();
    Map<String, dynamic> params = {"UserID": userId};
    params.putIfValueNotNull(key: "VoucherID", value: voucherId);
    getService(
        service: getCouponService(coupon),
        params: params,
        onException: failure,
        onSuccess: (response) {
          List<CouponModel> coupons = AppJsonParser.goodList(response, "result")
              .map((e) => CouponModel.fromJsonMap(e))
              ?.toList();
          onSuccess(coupons);
        });
  }

  Future<void> getVouchers({
    @required VOUCHER_TYPES voucher,
    onSuccess<List<VoucherModel>> onSuccess,
    onFailure failure,
  }) async {
    int userId = await getUserId();

    var params = {
      "UserID": userId,
      "vouchertype": getVoucherType(voucher),
    };
    getService(
        service: "VouchersOfUser",
        params: params,
        onException: failure,
        onSuccess: (response) {
          List<VoucherModel> vouchers =
              AppJsonParser.goodList(response, "result")
                  .map((e) => VoucherModel.fromJson(e))
                  ?.toList();
          onSuccess(vouchers);
        });
  }

  String getCouponService(COUPON_TYPES coupon) {
    switch (coupon) {
      case COUPON_TYPES.ACTIVE:
        return "getActiveCoupons";
      case COUPON_TYPES.SHARED:
        return "getSharedCoupons";

      case COUPON_TYPES.EXPIRED:
        return "getExpiredCoupons";

      case COUPON_TYPES.HISTORY:
        return "getCouponHistory";
    }
    return null;
  }

  String getVoucherType(VOUCHER_TYPES voucher) {
    switch (voucher) {
      case VOUCHER_TYPES.GIFTED:
        return "Gifted";

      case VOUCHER_TYPES.RECYCLED:
        return "Recycled";

      case VOUCHER_TYPES.EXPIRED:
        return "Expired";

      case VOUCHER_TYPES.USED:
        return "Used";
    }
    return null;
  }

  void redeemCoupon({
    @required CouponModel coupon,
    @required VoucherModel voucher,
    @required String businessId,
    double billAmount = 0,
    onSuccess<ResultModel> onSuccess,
    onFailure failure,
  }) async {
    String mobile = await getMobileNo();
    String town = await getSelectedTown();
   var params = {
      "CouponID": "${coupon?.userCouponId ?? 0}",
      "VoucherID": "${voucher?.userVoucherId ?? 0}",
      "Mobile": mobile,
      "Town": town,
      "Billamount": billAmount,
      "BusinessID": businessId,
      "api_key": await getApiKey,
      "UserID": await getUserId()
    };
    getService(
        service: "redeem",
        params: params,
        onException: failure,
        onSuccess: (response) {
          ResultModel result = ResultModel.fromJson(response);
          if (result?.result?.isNotEmpty ?? false) {
            if (result.result.contains("Success"))
              onSuccess(result);
            else
              failure(AppException(result.result, "Failed "));
          } else
            failure(
                FetchDataException("Something went wrong, Please try again"));
        });
  }

  void fetchCombinableVouchers({
    @required String couponId,
    @required onSuccess<List<VoucherModel>> onSuccess,
    @required onFailure failure,
  }) async {
    int userId = await getUserId();

    var params = {"UserID": userId, "CouponID": couponId};
    getService(
        service: "getVoucherInfo",
        params: params,
        onException: failure,
        onSuccess: (response) {
          List<VoucherModel> vouchers =
              AppJsonParser.goodList(response, 'result')
                  .map((e) => VoucherModel.fromJson(e))
                  ?.toList();

          onSuccess(vouchers);
        });
  }

  void cancelCoupon({
    CouponModel coupon,
    @required VoidCallback onSuccess,
    @required onFailure failure,
  }) async {

    String apiKey = await getApiKey;
    var params = {
      "CouponID": coupon.couponId,
      "UserID": await getUserId(),
      "UC_ID": coupon.ucId,
      "Mobile": await getMobileNo(),
      "api_key": apiKey,
    };

    getService(
        service: "CancelCoupon",
        params: params,
        onException: failure,
        onSuccess: (response) {
          String vouchers = AppJsonParser.goodString(response, 'result');
          if (vouchers.contains("Success"))
            onSuccess();
          else {
            failure(AppException("Failed to Cancel Coupon", "Failed "));
          }
        });
  }
}
