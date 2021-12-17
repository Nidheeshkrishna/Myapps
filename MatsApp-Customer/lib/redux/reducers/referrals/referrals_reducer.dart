import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/actions/referrals/referral_action.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/states/referrals/referrals_state.dart';
import 'package:redux/redux.dart';

import '../../models/loading_status.dart';

final referralsReducer = combineReducers<ReferralsState>([
  TypedReducer<ReferralsState, LoadingAction>(_changeLoadingStatusAction),
  TypedReducer<ReferralsState, ReferralsFetchedAction>(_referralsFetchedAction),
  TypedReducer<ReferralsState, AppliedReferralAction>(_applyReferralAction),
  TypedReducer<ReferralsState, OnClearAction>(_clearAction),
]);

ReferralsState _changeLoadingStatusAction(
    ReferralsState state, LoadingAction action) {
  return action.type == "Referrals"
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

ReferralsState _clearAction(ReferralsState state, OnClearAction action) {
  if (action.type == "Referrals")
    return ReferralsState.initial();
  else
    return state;
}

ReferralsState _referralsFetchedAction(
    ReferralsState state, ReferralsFetchedAction action) {
  return state.copyWith(
    loadingStatus: LoadingModel.success(),
    referral: action.referrals,
  );
}

ReferralsState _applyReferralAction(
    ReferralsState state, AppliedReferralAction action) {
  return state.copyWith(
    loadingStatus: LoadingModel.success(),
    referral: state.referral..anyReferenceLeft = false,
  );
}
