import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:matsapp/redux/actions/referrals/referral_action.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/base_view_model.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';

class ReferralsViewModel extends BaseViewModel {
  final VoidCallback getReferralDetails;
  final int totalReference;
  final String referenceAmount;
  final double earnedAmount;
  final String myReferralCode;
  final bool hasReference;
  final bool hasClaimAllow;
  final ValueSetter<String> onCouponRefer;

  ReferralsViewModel({
    LoadingModel loadingStatus,
    this.totalReference,
    this.referenceAmount,
    this.earnedAmount,
    this.myReferralCode,
    this.onCouponRefer,
    this.getReferralDetails,
    this.hasReference,
    this.hasClaimAllow,
  }) : super(loadingStatus);

  factory ReferralsViewModel.fromStore(Store<AppState> store) {
    var state = store.state.referralState;
    return ReferralsViewModel(
      loadingStatus: state.loadingStatus,
      earnedAmount: state.referral.earnedCoins,
      myReferralCode: state.referral.referralCode,
      referenceAmount: state.referral.amount,
      totalReference: state.referral.totalReferrals,
      hasReference: state.referral.anyReferenceLeft ?? false,
      hasClaimAllow: state.referral.claimAllow ?? false,
      onCouponRefer: (code) => store.dispatch(applyReferralDetails(code)),
      getReferralDetails: () => store.dispatch(fetchReferralDetails()),
    );
  }

  Future<void> copyToClipBoard() {
    return Clipboard.setData(new ClipboardData(text: myReferralCode));
  }

  void invite() {
    Share.share(
        "I'm inviting you to use Matsapp, Kerala's first Online to Offline application. Here's my code (" +
            myReferralCode +
            ") - just enter it while Signing up. You will get a bundle of Free coupons on your Registration & Enjoy your Savings. https://play.google.com/store/apps/details?id=in.matsapp.android \n App Store:https://apps.apple.com/in/app/matsapp/id1575534126",
        subject: "Invitation to Matsapp");
  }
}
