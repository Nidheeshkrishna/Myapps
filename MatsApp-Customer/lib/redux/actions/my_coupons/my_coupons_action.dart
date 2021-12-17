import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Modeles/coupon_generate/result_model.dart';
import 'package:matsapp/Modeles/coupon_generate/voucher_model.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/services/my_coupons/my_coupons_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../common_actions.dart';

class CouponsFetchedAction {
  final List<CouponModel> coupons;
  final COUPON_TYPES coupon;

  CouponsFetchedAction(this.coupons, this.coupon);
}

class VouchersFetchedAction {
  final List<VoucherModel> vouchers;
  final VOUCHER_TYPES voucher;

  VouchersFetchedAction(this.vouchers, this.voucher);
}

class CouponSelectedAction {
  final CouponModel coupon;

  CouponSelectedAction(this.coupon);
}

class BillValueChangeAction {
  final double billValue;

  BillValueChangeAction(this.billValue);
}

class CouponsRedeemedAction {
  final ResultModel result;
  final CouponModel coupon;
  final double value;

  CouponsRedeemedAction(
    this.result,
    this.coupon,
    this.value,
  );
}

class CouponCancelAction {
  final CouponModel coupon;

  CouponCancelAction(this.coupon);
}

class VouchersSelectedAction {
  final VoucherModel voucher;

  VouchersSelectedAction(this.voucher);
}

class RedeemScreenChangeAction {
  final BillAmountView view;

  RedeemScreenChangeAction(this.view);
}

class CompVouchersFetchedAction {
  final List<VoucherModel> vouchers;
  final List<CouponModel> coupons;

  final bool isVoucher;

  CompVouchersFetchedAction({
    this.vouchers,
    this.coupons,
    this.isVoucher,
  });
}

class RedeemClearAction {}

ThunkAction getCombinableVouchersAction(CouponModel selectedCoupon) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
        status: LoadingStatus.loading,
        message: "Loading Vouchers",
        type: "Redeem",
      ));
      MyCouponRepository().fetchCombinableVouchers(
          couponId: selectedCoupon.couponId,
          onSuccess: (result) {
            store.dispatch(
                CompVouchersFetchedAction(vouchers: result, isVoucher: true));
          },
          failure: (exception) => store.dispatch(LoadingAction(
                status: LoadingStatus.error,
                message: exception.toString(),
                type: "Redeem",
              )));
    });
  };
}

ThunkAction getCombinableCouponsAction(VoucherModel selectedVoucher) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
        status: LoadingStatus.loading,
        message: "Loading Coupons",
        type: "Redeem",
      ));
      MyCouponRepository().getCoupon(
          voucherId: selectedVoucher.id,
          coupon: COUPON_TYPES.ACTIVE,
          onSuccess: (result) {
            store.dispatch(CompVouchersFetchedAction(
              coupons: result,
              isVoucher: false,
            ));
          },
          failure: (exception) => store.dispatch(LoadingAction(
                status: LoadingStatus.error,
                message: exception.toString(),
                type: "Redeem",
              )));
    });
  };
}

ThunkAction redeemCouponAction(CouponModel coupon, VoucherModel voucher,
    double value, String businessCode) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
        status: LoadingStatus.loading,
        message: "Redeeming Coupons",
        type: "Redeem",
      ));
      MyCouponRepository().redeemCoupon(
          coupon: coupon,
          billAmount: value,
          voucher: voucher,
          businessId: businessCode,
          onSuccess: (result) {
            store.dispatch(CouponsRedeemedAction(result, coupon, value));
          },
          failure: (exception) => store.dispatch(LoadingAction(
              status: LoadingStatus.error,
              message: exception.toString(),
              type: "Redeem")));
    });
  };
}

ThunkAction fetchCouponsAction(COUPON_TYPES coupon) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
          status: LoadingStatus.loading,
          message: "Getting Coupons",
          type: coupon));

      MyCouponRepository().getCoupon(
          coupon: coupon,
          onSuccess: (result) {
            store.dispatch(CouponsFetchedAction(result, coupon));
          },
          failure: (exception) {
            store.dispatch(LoadingAction(
                status: LoadingStatus.error,
                message: exception.toString(),
                type: coupon));
          });
    });
  };
}

ThunkAction fetchVouchersAction(VOUCHER_TYPES vouchers) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
          status: LoadingStatus.loading,
          message: "Getting Vouchers",
          type: vouchers));
      MyCouponRepository().getVouchers(
          voucher: vouchers,
          onSuccess: (result) {
            store.dispatch(VouchersFetchedAction(result, vouchers));
          },
          failure: (exception) => store.dispatch(LoadingAction(
              status: LoadingStatus.error,
              message: exception.toString(),
              type: vouchers)));
    });
  };
}

ThunkAction onCancelCouponAction(CouponModel coupon) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
        status: LoadingStatus.loading,
        message: "Canceling Coupons",
        type: COUPON_TYPES.ACTIVE,
      ));
      MyCouponRepository().cancelCoupon(
          coupon: coupon,
          onSuccess: () {
            store.dispatch(CouponCancelAction(coupon));
          },
          failure: (exception) => store.dispatch(LoadingAction(
              status: LoadingStatus.error,
              message: exception.toString(),
              type: COUPON_TYPES.ACTIVE)));
    });
  };
}
