import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/redux/actions/generate_coupon/generate_coupon_actions.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/states/generate_coupon/generate_coupon_state.dart';
import 'package:matsapp/redux/viewModels/base_view_model.dart';
import 'package:redux/redux.dart';

class GenerateCouponViewModel extends BaseViewModel {
  final CouponModel coupon;

  // final int multiplier;
  final Function(String, String) initialise;
  final Function(int, CouponModel) onCouponUpdate;

  GenerateCouponViewModel({
    LoadingModel loadingStatus,
    this.coupon,
    // this.multiplier,
    this.initialise,
    this.onCouponUpdate,
  }) : super(loadingStatus);

  factory GenerateCouponViewModel.fromStore(Store<AppState> store) {
    GenerateCouponState state = store.state.generateCouponState;
    return GenerateCouponViewModel(
      loadingStatus: state.loadingStatus,
      coupon: state.coupon,
      // multiplier: state.multiplier,
      //methods

      initialise: (coupon, type) =>
          store.dispatch(fetchCouponDetailsAction(coupon, type)),

      // onCouponUpdate: (value, coupon) =>
      //     store.dispatch(CouponMultiplierChangeAction(value, coupon)),
    );
  }

  // void onMultiplierChanged(int changedMultiplier) {
  //   if (changedMultiplier > 0) {
  //     double purchaseValue, purchaseLimit, couponValue;
  //     double saverupee;
  //     couponValue = (coupon.couponValue / multiplier) * changedMultiplier;
  //     purchaseLimit = (coupon.purchaseLimit / multiplier) * changedMultiplier;
  //     purchaseValue = (coupon.purchaseValue / multiplier) * changedMultiplier;
  //     couponValue = purchaseLimit * coupon.matsappDiscount / 100;
  //     coupon.purchaseValue = purchaseValue;
  //     coupon.purchaseLimit = purchaseLimit;
  //     coupon.couponValue = couponValue;

  //     saverupee = couponValue - purchaseValue;
  //     coupon.yourSavings = saverupee;

  //     onCouponUpdate(changedMultiplier, coupon);
  //   }
  // }
}
