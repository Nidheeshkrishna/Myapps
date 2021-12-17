enum COUPON_TYPES { ACTIVE, SHARED, EXPIRED, HISTORY }
enum VOUCHER_TYPES { GIFTED, RECYCLED, EXPIRED, USED }
enum BillAmountView { COMBO_VOUCHER, REDEEM_VOUCHER, BILL_COUPON }

extension RedeemStateExtension on BillAmountView {
  bool get isComboScreen => this == BillAmountView.COMBO_VOUCHER;

  bool get isBillScreen => this == BillAmountView.BILL_COUPON;

  bool get isRedeemScreen => this == BillAmountView.REDEEM_VOUCHER;
}
