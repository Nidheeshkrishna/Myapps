import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/actions/my_coupons/my_coupons_action.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/redux/states/my_coupons/my_coupon_state.dart';
import 'package:redux/redux.dart';

final myCouponReducer = combineReducers<MyCouponState>([
  TypedReducer<MyCouponState, LoadingAction>(_changeLoadingStatusAction),
  TypedReducer<MyCouponState, OnClearAction>(_clearAction),
  TypedReducer<MyCouponState, RedeemClearAction>(_redeemClearAction),
  TypedReducer<MyCouponState, CouponsFetchedAction>(_couponsFetchedAction),
  TypedReducer<MyCouponState, VouchersFetchedAction>(_voucherFetchedAction),
  TypedReducer<MyCouponState, CouponSelectedAction>(_couponSelectedAction),
  TypedReducer<MyCouponState, BillValueChangeAction>(_billAmountChangeAction),
  TypedReducer<MyCouponState, CouponsRedeemedAction>(_couponRedeemedAction),
  TypedReducer<MyCouponState, CompVouchersFetchedAction>(
      _compVoucherFetchedAction),
  TypedReducer<MyCouponState, RedeemScreenChangeAction>(_changeViewAction),
  TypedReducer<MyCouponState, VouchersSelectedAction>(_compVoucherSelectAction),
]);

MyCouponState _changeLoadingStatusAction(
    MyCouponState state, LoadingAction action) {
  if (state.couponsLoadingStatus.containsKey(action.type)) {
    var loadingStatues = state.couponsLoadingStatus;
    loadingStatues[action.type] = LoadingModel(
      loadingStatus: action.status,
      loadingMessage: action.message,
      loadingError: action.message,
      action: action.action,
      actionCallback: action.onAction,
    );
    return state.copyWith(couponsLoadingStatus: loadingStatues);
  } else if (state.vouchersLoadingStatus.containsKey(action.type)) {
    var loadingStatues = state.vouchersLoadingStatus;
    loadingStatues[action.type] = LoadingModel(
      loadingStatus: action.status,
      loadingMessage: action.message,
      loadingError: action.message,
      action: action.action,
      actionCallback: action.onAction,
    );
    return state.copyWith(vouchersLoadingStatus: loadingStatues);
  } else if (action.type == "Redeem") {
    return state.copyWith(
        redeemLoadingStatus: LoadingModel(
      loadingStatus: action.status,
      loadingMessage: action.message,
      loadingError: action.message,
      action: action.action,
      actionCallback: action.onAction,
    ));
  }
  return state;
}

MyCouponState _clearAction(MyCouponState state, OnClearAction action) {
  return state;
}

MyCouponState _couponsFetchedAction(
    MyCouponState state, CouponsFetchedAction action) {
  var loadingStatus = state.couponsLoadingStatus;
  loadingStatus[action.coupon] = LoadingModel.success();

  switch (action.coupon) {
    case COUPON_TYPES.ACTIVE:
      return state.copyWith(
        redeemLoadingStatus: LoadingModel.success(),
        couponsLoadingStatus: loadingStatus,
        activeCoupons: action.coupons,
      );

    case COUPON_TYPES.SHARED:
      return state.copyWith(
        redeemLoadingStatus: LoadingModel.success(),
        couponsLoadingStatus: loadingStatus,
        sharedCoupons: action.coupons,
      );
    case COUPON_TYPES.EXPIRED:
      return state.copyWith(
        redeemLoadingStatus: LoadingModel.success(),
        couponsLoadingStatus: loadingStatus,
        expiredCoupons: action.coupons,
      );
    case COUPON_TYPES.HISTORY:
      return state.copyWith(
        redeemLoadingStatus: LoadingModel.success(),
        couponsLoadingStatus: loadingStatus,
        historyCoupons: action.coupons,
      );
  }
  return state.copyWith(
    redeemLoadingStatus: LoadingModel.success(),
  );
}

MyCouponState _voucherFetchedAction(
    MyCouponState state, VouchersFetchedAction action) {
  var loadingStatus = state.vouchersLoadingStatus;
  loadingStatus[action.voucher] = LoadingModel.success();
  switch (action.voucher) {
    case VOUCHER_TYPES.GIFTED:
      return state.copyWith(
        vouchersLoadingStatus: loadingStatus,
        giftedVouchers: action.vouchers,
      );
    case VOUCHER_TYPES.RECYCLED:
      return state.copyWith(
        vouchersLoadingStatus: loadingStatus,
        recycledVouchers: action.vouchers,
      );
    case VOUCHER_TYPES.EXPIRED:
      return state.copyWith(
        vouchersLoadingStatus: loadingStatus,
        expiredVouchers: action.vouchers,
      );
    case VOUCHER_TYPES.USED:
      return state.copyWith(
        vouchersLoadingStatus: loadingStatus,
        usedVouchers: action.vouchers,
      );
  }
  return state.copyWith();
}

MyCouponState _couponSelectedAction(
    MyCouponState state, CouponSelectedAction action) {

  var coupon = state.selectedCoupon;
  coupon = coupon?.couponId == action.coupon.couponId ? null : action.coupon;
  return state.copyWith(
    selectedVoucher: state.selectedVoucher,
    deselect: true,
    selectedCoupon: coupon,
  );
}

MyCouponState _compVoucherSelectAction(
    MyCouponState state, VouchersSelectedAction action) {
  var voucher = state.selectedVoucher;
  voucher = voucher?.id == action.voucher.id ? null : action.voucher;
  return state.copyWith(
    selectedVoucher: voucher,
    deselect: true,
    selectedCoupon: state.selectedCoupon,
  );
}

MyCouponState _couponRedeemedAction(
    MyCouponState state, CouponsRedeemedAction action) {
  return state.copyWith(
    redeemLoadingStatus: LoadingModel.success(),
    billAmount: action.value,
    isRedeemed: true,
  );
}

MyCouponState _compVoucherFetchedAction(
    MyCouponState state, CompVouchersFetchedAction action) {
  return state.copyWith(
    comboVouchers: action.vouchers,
    comboCoupons: action.coupons,
    redeemState: (action.vouchers?.isEmpty ?? false) ||
            (action.coupons?.isEmpty ?? false)
        ? BillAmountView.BILL_COUPON
        : BillAmountView.COMBO_VOUCHER,
    redeemLoadingStatus: LoadingModel.success(),
  );
}

MyCouponState _changeViewAction(
    MyCouponState state, RedeemScreenChangeAction action) {
  return state.copyWith(
    redeemState: action.view,
  );
}

MyCouponState _redeemClearAction(
    MyCouponState state, RedeemClearAction action) {
  return state.clearBill();
}

MyCouponState _billAmountChangeAction(
    MyCouponState state, BillValueChangeAction action) {
  return state.copyWith(
    billAmount: action.billValue,
  );
}
