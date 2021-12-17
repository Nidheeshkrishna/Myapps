import 'package:flutter/widgets.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Modeles/coupon_generate/voucher_model.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';

@immutable
class MyCouponState {
  final Map<COUPON_TYPES, LoadingModel> couponsLoadingStatus;
  final Map<VOUCHER_TYPES, LoadingModel> vouchersLoadingStatus;

  final List<CouponModel> activeCoupons;
  final List<CouponModel> sharedCoupons;
  final List<CouponModel> expiredCoupons;
  final List<CouponModel> historyCoupons;

  final List<VoucherModel> giftedVouchers;
  final List<VoucherModel> recycledVouchers;
  final List<VoucherModel> expiredVouchers;
  final List<VoucherModel> usedVouchers;

  final CouponModel selectedCoupon;
  final VoucherModel selectedVoucher;

  final LoadingModel redeemLoadingStatus;
  final List<VoucherModel> comboVouchers;
  final List<CouponModel> comboCoupons;
  final BillAmountView redeemState;

  final double billAmount;
  final bool isRedeemed;

  MyCouponState({
    this.couponsLoadingStatus,
    this.vouchersLoadingStatus,
    this.activeCoupons,
    this.sharedCoupons,
    this.expiredCoupons,
    this.historyCoupons,
    this.giftedVouchers,
    this.recycledVouchers,
    this.expiredVouchers,
    this.usedVouchers,
    this.selectedCoupon,
    this.redeemLoadingStatus,
    this.comboVouchers,
    this.selectedVoucher,
    this.redeemState,
    this.billAmount,
    this.isRedeemed,
    this.comboCoupons,
  });

  MyCouponState copyWith({
    Map<COUPON_TYPES, LoadingModel> couponsLoadingStatus,
    Map<VOUCHER_TYPES, LoadingModel> vouchersLoadingStatus,
    List<CouponModel> activeCoupons,
    List<CouponModel> sharedCoupons,
    List<CouponModel> expiredCoupons,
    List<CouponModel> historyCoupons,
    List<VoucherModel> giftedVouchers,
    List<VoucherModel> recycledVouchers,
    List<VoucherModel> expiredVouchers,
    List<VoucherModel> usedVouchers,
    LoadingModel redeemLoadingStatus,
    List<VoucherModel> comboVouchers,
    VoucherModel selectedVoucher,
    CouponModel selectedCoupon,
    bool deselect = false,
    BillAmountView redeemState,
    double billAmount,
    bool isRedeemed,
    List<CouponModel> comboCoupons,
  }) {
    return MyCouponState(
      couponsLoadingStatus: couponsLoadingStatus ?? this.couponsLoadingStatus,
      vouchersLoadingStatus:
          vouchersLoadingStatus ?? this.vouchersLoadingStatus,
      activeCoupons: activeCoupons ?? this.activeCoupons,
      sharedCoupons: sharedCoupons ?? this.sharedCoupons,
      expiredCoupons: expiredCoupons ?? this.expiredCoupons,
      historyCoupons: historyCoupons ?? this.historyCoupons,
      giftedVouchers: giftedVouchers ?? this.giftedVouchers,
      recycledVouchers: recycledVouchers ?? this.recycledVouchers,
      expiredVouchers: expiredVouchers ?? this.expiredVouchers,
      usedVouchers: usedVouchers ?? this.usedVouchers,
      redeemLoadingStatus: redeemLoadingStatus ?? this.redeemLoadingStatus,
      comboVouchers: comboVouchers ?? this.comboVouchers,
      comboCoupons: comboCoupons ?? this.comboCoupons,
      selectedVoucher:
          deselect ? selectedVoucher : selectedVoucher ?? this.selectedVoucher,
      selectedCoupon:
          deselect ? selectedCoupon : selectedCoupon ?? this.selectedCoupon,
      redeemState: redeemState ?? this.redeemState,
      billAmount: billAmount ?? this.billAmount,
      isRedeemed: isRedeemed ?? this.isRedeemed,
    );
  }

  MyCouponState clearBill() {
    return MyCouponState(
      couponsLoadingStatus: this.couponsLoadingStatus,
      vouchersLoadingStatus: this.vouchersLoadingStatus,
      activeCoupons: this.activeCoupons,
      sharedCoupons: this.sharedCoupons,
      expiredCoupons: this.expiredCoupons,
      historyCoupons: this.historyCoupons,
      giftedVouchers: this.giftedVouchers,
      recycledVouchers: this.recycledVouchers,
      expiredVouchers: this.expiredVouchers,
      usedVouchers: this.usedVouchers,
      redeemState: BillAmountView.COMBO_VOUCHER,
      billAmount: 0,
      redeemLoadingStatus: LoadingModel.success(),
      selectedVoucher: null,
      selectedCoupon: null,
      isRedeemed: false,
      comboVouchers: [],
      comboCoupons: [],
    );
  }

  factory MyCouponState.initial() {
    Map<COUPON_TYPES, LoadingModel> couponsStatuses = Map();
    Map<VOUCHER_TYPES, LoadingModel> vouchersStatuses = Map();
    COUPON_TYPES.values
        .forEach((e) => couponsStatuses[e] = LoadingModel.initial());
    VOUCHER_TYPES.values
        .forEach((e) => vouchersStatuses[e] = LoadingModel.initial());

    return MyCouponState(
      redeemLoadingStatus: LoadingModel.initial(),
      couponsLoadingStatus: couponsStatuses,
      vouchersLoadingStatus: vouchersStatuses,
      selectedCoupon: null,
      selectedVoucher: null,
      activeCoupons: [],
      comboVouchers: [],
      sharedCoupons: [],
      comboCoupons: [],
      expiredCoupons: [],
      historyCoupons: [],
      giftedVouchers: [],
      recycledVouchers: [],
      expiredVouchers: [],
      usedVouchers: [],
      redeemState: BillAmountView.COMBO_VOUCHER,
      billAmount: 0,
      isRedeemed: false,
    );
  }
}
