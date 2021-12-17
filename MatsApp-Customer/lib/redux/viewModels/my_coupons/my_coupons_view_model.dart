import 'package:flutter/cupertino.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/redux/actions/my_coupons/my_coupons_action.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/base_view_model.dart';
import 'package:redux/redux.dart';

class ActiveCouponsViewModel extends BaseViewModel {
  final List<CouponModel> activeCoupons;
  final VoidCallback getCoupons;
  final ValueSetter<CouponModel> onCouponSelect;
  final VoidCallback clearSelected;

  ActiveCouponsViewModel({
    LoadingModel loadingStatus,
    this.activeCoupons,
    this.getCoupons,
    this.onCouponSelect,
    this.clearSelected,
  }) : super(loadingStatus);

  factory ActiveCouponsViewModel.fromStore(Store<AppState> store) {
    var state = store.state.myCouponState;

    return ActiveCouponsViewModel(
      loadingStatus: state.couponsLoadingStatus[COUPON_TYPES.ACTIVE],
      activeCoupons: state.activeCoupons,
      getCoupons: () => store.dispatch(fetchCouponsAction(COUPON_TYPES.ACTIVE)),
      onCouponSelect: (coupon) => store.dispatch(CouponSelectedAction(coupon)),
      clearSelected: () => store.dispatch(RedeemClearAction()),
    );
  }
}

class SharedCouponsViewModel extends BaseViewModel {
  final List<CouponModel> sharedCoupons;
  final VoidCallback getCoupons;

  SharedCouponsViewModel({
    LoadingModel loadingStatus,
    this.sharedCoupons,
    this.getCoupons,
  }) : super(loadingStatus);

  factory SharedCouponsViewModel.fromStore(Store<AppState> store) {
    var state = store.state.myCouponState;
    return SharedCouponsViewModel(
      loadingStatus: state.couponsLoadingStatus[COUPON_TYPES.SHARED],
      sharedCoupons: state.sharedCoupons,
      getCoupons: () => store.dispatch(fetchCouponsAction(COUPON_TYPES.SHARED)),
    );
  }
}

class ExpiredCouponsViewModel extends BaseViewModel {
  final List<CouponModel> expiredCoupons;
  final VoidCallback getCoupons;

  ExpiredCouponsViewModel({
    LoadingModel loadingStatus,
    this.expiredCoupons,
    this.getCoupons,
  }) : super(loadingStatus);

  factory ExpiredCouponsViewModel.fromStore(Store<AppState> store) {
    var state = store.state.myCouponState;
    return ExpiredCouponsViewModel(
      loadingStatus: state.couponsLoadingStatus[COUPON_TYPES.EXPIRED],
      expiredCoupons: state.expiredCoupons,
      getCoupons: () =>
          store.dispatch(fetchCouponsAction(COUPON_TYPES.EXPIRED)),
    );
  }
}

class HistoryCouponsViewModel extends BaseViewModel {
  final List<CouponModel> historyCoupons;
  final VoidCallback getCoupons;

  HistoryCouponsViewModel({
    LoadingModel loadingStatus,
    this.historyCoupons,
    this.getCoupons,
  }) : super(loadingStatus);

  factory HistoryCouponsViewModel.fromStore(Store<AppState> store) {
    var state = store.state.myCouponState;
    return HistoryCouponsViewModel(
      loadingStatus: state.couponsLoadingStatus[COUPON_TYPES.HISTORY],
      historyCoupons: state.historyCoupons,
      getCoupons: () =>
          store.dispatch(fetchCouponsAction(COUPON_TYPES.HISTORY)),
    );
  }
}
