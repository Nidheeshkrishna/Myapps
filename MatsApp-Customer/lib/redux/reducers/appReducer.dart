import 'package:matsapp/redux/reducers/find/find_reducer.dart';
import 'package:matsapp/redux/reducers/my_coupons/my_coupon_reducer.dart';
import 'package:matsapp/redux/reducers/notifications/notifications_reducer.dart';
import 'package:matsapp/redux/reducers/referrals/referrals_reducer.dart';
import 'package:matsapp/redux/states/appState.dart';

import 'generate_coupon/generate_coupon_reducer.dart';

AppState appReducer(AppState state, dynamic action) => state.copyWith(
      generateCouponState:
          generateCouponReducer(state.generateCouponState, action),
      myCouponState: myCouponReducer(state.myCouponState, action),
      referralState: referralsReducer(state.referralState, action),
      notificationsState:
          notificationsReducer(state.notificationsState, action),
      findState: findReducer(state.findState, action),
    );
