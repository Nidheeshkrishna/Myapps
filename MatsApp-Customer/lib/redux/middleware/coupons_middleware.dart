import 'package:matsapp/redux/actions/my_coupons/my_coupons_action.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createCouponMiddleware() => [
      TypedMiddleware<AppState, CouponCancelAction>(_onCouponCancel),
      TypedMiddleware<AppState, CouponsRedeemedAction>(_onCouponRedeem),
    ];

Future _onCouponCancel(Store<AppState> store, CouponCancelAction action,
    NextDispatcher next) async {
  //refresh active coupons on coupon cancel
  store.dispatch(fetchCouponsAction(COUPON_TYPES.ACTIVE));

  next(action);
}

Future _onCouponRedeem(Store<AppState> store, CouponsRedeemedAction action,
    NextDispatcher next) async {
  //refresh active coupons on coupon/voucher redeem
  store.dispatch(fetchCouponsAction(COUPON_TYPES.ACTIVE));
  store.dispatch(fetchVouchersAction(VOUCHER_TYPES.GIFTED));

  next(action);
}
