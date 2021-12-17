import 'package:flutter/widgets.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/redux/models/loading_status.dart';

@immutable
class GenerateCouponState {
  final LoadingModel loadingStatus;
  final CouponModel coupon;

  final int multiplier;

  GenerateCouponState({
    this.loadingStatus,
    this.coupon,
    this.multiplier,
  });

  GenerateCouponState copyWith({
    LoadingModel loadingStatus,
    CouponModel coupon,
    CouponModel actualCoupon,
    int multiplier,
  }) {
    return GenerateCouponState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      coupon: coupon ?? this.coupon,
      multiplier: multiplier ?? this.multiplier,
    );
  }

  factory GenerateCouponState.initial() {
    return GenerateCouponState(
      loadingStatus: LoadingModel.initial(),
      coupon: null,
      multiplier: 1,
    );
  }
}
