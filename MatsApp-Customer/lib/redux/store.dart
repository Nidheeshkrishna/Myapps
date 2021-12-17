import 'dart:async';

import 'package:matsapp/redux/middleware/coupons_middleware.dart';
import 'package:matsapp/redux/reducers/appReducer.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

Future<Store<AppState>> createStore() async {
  // var prefs = await SharedPreferences.getInstance();
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, ...createCouponMiddleware()],
  );
}
