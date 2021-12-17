import 'package:matsapp/Modeles/referrals/referrals_model.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/services/referrals/referrals_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../common_actions.dart';

class ReferralsFetchedAction {
  final ReferralsModel referrals;

  ReferralsFetchedAction(this.referrals);
}

class AppliedReferralAction {}

ThunkAction fetchReferralDetails() {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
        status: LoadingStatus.loading,
        message: "Loading ",
        type: "Referrals",
      ));
      ReferralsRepository().fetchReferralDetails(
          onSuccess: (result) {
            store.dispatch(ReferralsFetchedAction(result));
          },
          failure: (exception) => store.dispatch(LoadingAction(
                status: LoadingStatus.error,
                message: exception.toString(),
                type: "Referrals",
              )));
    });
  };
}

ThunkAction applyReferralDetails(String code) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
        status: LoadingStatus.loading,
        message: "Loading ",
        type: "Referrals",
      ));
      ReferralsRepository().applyReferral(
          code: code,
          onSuccess: (result) {
            store.dispatch(AppliedReferralAction());
          },
          failure: (exception) => store.dispatch(LoadingAction(
                status: LoadingStatus.error,
                message: exception.toString(),
                type: "Referrals",
              )));
    });
  };
}
