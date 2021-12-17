import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Modeles/coupon_generate/result_model.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/services/coupons_generate/coupons_generate_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../common_actions.dart';

class CouponDetailFetchedAction {
  final CouponModel coupon;

  CouponDetailFetchedAction(this.coupon);
}

class CouponMultiplierChangeAction {
  final int value;
  final CouponModel coupon;

  CouponMultiplierChangeAction(this.value, this.coupon);
}

class CouponBuySuccessAction {
  final ResultModel result;

  CouponBuySuccessAction(this.result);
}

ThunkAction fetchCouponDetailsAction(String coupon, String type) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
          status: LoadingStatus.loading,
          message: "Initializing",
          type: "GenerateCoupon"));
      CouponGenerateRepository().getCouponDetails(
          couponId: coupon,
          type: type,
          onSuccess: (coupon) {
            store.dispatch(CouponDetailFetchedAction(coupon));
          },
          failure: (exception) => store.dispatch(LoadingAction(
              status: LoadingStatus.error,
              message: exception.toString(),
              type: "GenerateCoupon")));
    });
  };
}

ThunkAction buyCouponAction(CouponModel coupon, int multiplier) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
          status: LoadingStatus.loading,
          message: "Generating Coupon",
          type: "GenerateCoupon"));
      CouponGenerateRepository().buyCoupon(
          coupon: coupon,
          multiplier: multiplier,
          onSuccess: (result) {
            store.dispatch(CouponBuySuccessAction(result));
          },
          failure: (exception) => store.dispatch(LoadingAction(
              status: LoadingStatus.error,
              message: exception.toString(),
              type: "GenerateCoupon")));
    });
  };
}
