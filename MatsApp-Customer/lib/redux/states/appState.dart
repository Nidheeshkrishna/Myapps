import 'package:flutter/material.dart';
import 'package:matsapp/redux/states/find/find_state.dart';
import 'package:matsapp/redux/states/my_coupons/my_coupon_state.dart';
import 'package:matsapp/redux/states/notifications/notificaiton_state.dart';
import 'package:matsapp/redux/states/referrals/referrals_state.dart';

import 'generate_coupon/generate_coupon_state.dart';

@immutable
class AppState {
  final GenerateCouponState generateCouponState;
  final MyCouponState myCouponState;
  final ReferralsState referralState;
  final NotificationsState notificationsState;
  final FindState findState;

  AppState({
    @required this.generateCouponState,
    @required this.myCouponState,
    @required this.referralState,
    @required this.notificationsState,
    @required this.findState,
  });

  AppState copyWith({
    GenerateCouponState generateCouponState,
    MyCouponState myCouponState,
    ReferralsState referralState,
    NotificationsState notificationsState,
    FindState findState,
  }) {
    return AppState(
      generateCouponState: generateCouponState ?? this.generateCouponState,
      myCouponState: myCouponState ?? this.myCouponState,
      referralState: referralState ?? this.referralState,
      notificationsState: notificationsState ?? this.notificationsState,
      findState: findState ?? this.findState,
    );
  }

  factory AppState.initial() {
    return AppState(
      generateCouponState: GenerateCouponState.initial(),
      myCouponState: MyCouponState.initial(),
      referralState: ReferralsState.initial(),
      notificationsState: NotificationsState.initial(),
      findState: FindState.initial(),
    );
  }
}
