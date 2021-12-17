import 'package:flutter/cupertino.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Modeles/coupon_generate/voucher_model.dart';
import 'package:matsapp/redux/actions/my_coupons/my_coupons_action.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/states/my_coupons/my_coupon_state.dart';
import 'package:matsapp/redux/viewModels/base_view_model.dart';
import 'package:redux/redux.dart';

class RedeemCouponViewModel extends BaseViewModel {
  final CouponModel coupon;
  final VoucherModel voucher;
  final double billAmount;
  final List<VoucherModel> comboVouchers;
  final List<CouponModel> comboCoupons;
  final BillAmountView redeemState;
  final Function(String) onRedeem;
  final Function(double) onBillChange;
  final Function(VoucherModel) onComboVoucherSelect;
  final Function(CouponModel) onComboCouponSelect;
  final Function() getVouchers;
  final Function() onCancelCoupon;
  final VoidCallback onCombineVoucher;
  final VoidCallback onChangeVoucher;
  final VoidCallback onClear;

  final bool isRedeemed;

  RedeemCouponViewModel({
    LoadingModel loadingStatus,
    this.coupon,
    this.comboCoupons,
    this.onRedeem,
    this.getVouchers,
    this.voucher,
    this.comboVouchers,
    this.onComboVoucherSelect,
    this.onComboCouponSelect,
    this.redeemState,
    this.onCombineVoucher,
    this.billAmount,
    this.isRedeemed,
    this.onClear,
    this.onChangeVoucher,
    this.onBillChange,
    this.onCancelCoupon,
  }) : super(loadingStatus);

  factory RedeemCouponViewModel.fromStore(Store<AppState> store) {
    MyCouponState state = store.state.myCouponState;
    return RedeemCouponViewModel(
      loadingStatus: state.redeemLoadingStatus,
      coupon: state.selectedCoupon,
      voucher: state.selectedVoucher,
      comboVouchers: state.comboVouchers ?? [],
      redeemState: state.redeemState,
      billAmount: state.billAmount,
      isRedeemed: state.isRedeemed,
      comboCoupons: state.comboCoupons ?? [],
      onRedeem: (value) => store.dispatch(redeemCouponAction(
          state.selectedCoupon,
          state.selectedVoucher,
          state.billAmount,
          value)),
      getVouchers: () {
        if (state.selectedCoupon != null)
          store.dispatch(getCombinableVouchersAction(state.selectedCoupon));
        else if (state.selectedVoucher != null)
          store.dispatch(getCombinableCouponsAction(state.selectedVoucher));
      },
      onChangeVoucher: () => store
          .dispatch(RedeemScreenChangeAction(BillAmountView.COMBO_VOUCHER)),
      onCombineVoucher: () {
        var view = state.selectedVoucher == null || state.selectedCoupon == null
            ? BillAmountView.BILL_COUPON
            : BillAmountView.REDEEM_VOUCHER;
        store.dispatch(RedeemScreenChangeAction(view));
      },
      onBillChange: (billValue) =>
          store.dispatch(BillValueChangeAction(billValue)),
      onComboVoucherSelect: (voucher) =>
          store.dispatch(VouchersSelectedAction(voucher)),
      onComboCouponSelect: (coupon) =>
          store.dispatch(CouponSelectedAction(coupon)),
      onCancelCoupon: () {
        store.dispatch(onCancelCouponAction(state.selectedCoupon));
      },
      onClear: () => store.dispatch(RedeemClearAction()),
    );
  }

  double getDiscountValue() {
    if (coupon != null)
      return coupon.couponValue;
    else if (voucher != null)
      return voucher.voucherValue;
    else
      return 0;
  }
}
