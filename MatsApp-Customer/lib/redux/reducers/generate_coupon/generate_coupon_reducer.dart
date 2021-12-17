import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/actions/generate_coupon/generate_coupon_actions.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/states/generate_coupon/generate_coupon_state.dart';
import 'package:redux/redux.dart';

final generateCouponReducer = combineReducers<GenerateCouponState>([
  TypedReducer<GenerateCouponState, LoadingAction>(_changeLoadingStatusAction),
  TypedReducer<GenerateCouponState, OnClearAction>(_clearAction),
  TypedReducer<GenerateCouponState, CouponDetailFetchedAction>(
      _couponFetchedAction),
  TypedReducer<GenerateCouponState, CouponBuySuccessAction>(_couponBuyAction),
  TypedReducer<GenerateCouponState, CouponMultiplierChangeAction>(
      _multiplierChangeAction),
]);

GenerateCouponState _changeLoadingStatusAction(
    GenerateCouponState state, LoadingAction action) {
  return action.type == "GenerateCoupon"
      ? state.copyWith(
          loadingStatus: LoadingModel(
          loadingStatus: action.status,
          loadingMessage: action.message,
          loadingError: action.message,
          action: action.action,
          actionCallback: action.onAction,
        ))
      : state;
}

GenerateCouponState _couponFetchedAction(
    GenerateCouponState state, CouponDetailFetchedAction action) {
  return state.copyWith(
    loadingStatus: LoadingModel.success(),
    coupon: action.coupon,
    actualCoupon: action.coupon,
  );
}

GenerateCouponState _multiplierChangeAction(
    GenerateCouponState state, CouponMultiplierChangeAction action) {
  int multiplier = action.value;
  return state.copyWith(coupon: action.coupon, multiplier: multiplier);
}

GenerateCouponState _clearAction(
    GenerateCouponState state, OnClearAction action) {
  return GenerateCouponState.initial();
}

GenerateCouponState _couponBuyAction(
    GenerateCouponState state, CouponBuySuccessAction action) {
  return state.copyWith(
    loadingStatus: LoadingModel.success(),
  );
}
