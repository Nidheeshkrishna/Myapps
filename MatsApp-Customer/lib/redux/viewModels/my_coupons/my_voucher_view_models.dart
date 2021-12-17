import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/coupon_generate/voucher_model.dart';
import 'package:matsapp/redux/actions/my_coupons/my_coupons_action.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/base_view_model.dart';
import 'package:redux/redux.dart';

class GiftedVouchersViewModel extends BaseViewModel {
  final List<VoucherModel> vouchers;
  final VoidCallback getVouchers;
  final Function(VoucherModel) onVoucherSelect;
  final VoidCallback clearSelected;

  GiftedVouchersViewModel({
    LoadingModel loadingStatus,
    this.vouchers,
    this.getVouchers,
    this.onVoucherSelect,
    this.clearSelected,
  }) : super(loadingStatus);

  factory GiftedVouchersViewModel.fromStore(Store<AppState> store) {
    var state = store.state.myCouponState;
    return GiftedVouchersViewModel(
      loadingStatus: state.vouchersLoadingStatus[VOUCHER_TYPES.GIFTED],
      vouchers: state.giftedVouchers,
      getVouchers: () =>
          store.dispatch(fetchVouchersAction(VOUCHER_TYPES.GIFTED)),
      onVoucherSelect: (voucher) =>
          store.dispatch(VouchersSelectedAction(voucher)),
      clearSelected: () => store.dispatch(RedeemClearAction()),
    );
  }
}

class RecycledVouchersViewModel extends BaseViewModel {
  final List<VoucherModel> vouchers;
  final VoidCallback getVouchers;

  RecycledVouchersViewModel({
    LoadingModel loadingStatus,
    this.vouchers,
    this.getVouchers,
  }) : super(loadingStatus);

  factory RecycledVouchersViewModel.fromStore(Store<AppState> store) {
    var state = store.state.myCouponState;
    return RecycledVouchersViewModel(
      loadingStatus: state.vouchersLoadingStatus[VOUCHER_TYPES.RECYCLED],
      vouchers: state.recycledVouchers,
      getVouchers: () =>
          store.dispatch(fetchVouchersAction(VOUCHER_TYPES.RECYCLED)),
    );
  }
}

class ExpiredVouchersViewModel extends BaseViewModel {
  final List<VoucherModel> vouchers;
  final VoidCallback getVouchers;

  ExpiredVouchersViewModel({
    LoadingModel loadingStatus,
    this.vouchers,
    this.getVouchers,
  }) : super(loadingStatus);

  factory ExpiredVouchersViewModel.fromStore(Store<AppState> store) {
    var state = store.state.myCouponState;
    return ExpiredVouchersViewModel(
      loadingStatus: state.vouchersLoadingStatus[VOUCHER_TYPES.EXPIRED],
      vouchers: state.expiredVouchers,
      getVouchers: () =>
          store.dispatch(fetchVouchersAction(VOUCHER_TYPES.EXPIRED)),
    );
  }
}

class UsedVouchersViewModel extends BaseViewModel {
  final List<VoucherModel> vouchers;
  final VoidCallback getVouchers;

  UsedVouchersViewModel({
    LoadingModel loadingStatus,
    this.vouchers,
    this.getVouchers,
  }) : super(loadingStatus);

  factory UsedVouchersViewModel.fromStore(Store<AppState> store) {
    var state = store.state.myCouponState;
    return UsedVouchersViewModel(
      loadingStatus: state.vouchersLoadingStatus[VOUCHER_TYPES.USED],
      vouchers: state.usedVouchers,
      getVouchers: () =>
          store.dispatch(fetchVouchersAction(VOUCHER_TYPES.USED)),
    );
  }
}
