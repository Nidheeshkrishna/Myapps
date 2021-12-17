import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/redux/actions/generate_coupon/generate_coupon_actions.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/states/generate_coupon/generate_coupon_state.dart';
import 'package:matsapp/redux/viewModels/base_view_model.dart';
import 'package:redux/redux.dart';

class BuyCouponViewModel extends BaseViewModel {
  final CouponModel coupon;
  final Function() onBuy;

  BuyCouponViewModel({
    LoadingModel loadingStatus,
    this.coupon,
    this.onBuy,
  }) : super(loadingStatus);

  factory BuyCouponViewModel.fromStore(Store<AppState> store) {
    GenerateCouponState state = store.state.generateCouponState;
    return BuyCouponViewModel(
      loadingStatus: state.loadingStatus,
      coupon: state.coupon,

      //methods
      onBuy: () =>
          store.dispatch(buyCouponAction(state.coupon, state.multiplier)),
    );
  }
}
