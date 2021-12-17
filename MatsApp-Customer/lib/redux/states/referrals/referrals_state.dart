import 'package:flutter/widgets.dart';
import 'package:matsapp/Modeles/referrals/referrals_model.dart';
import 'package:matsapp/redux/models/loading_status.dart';

@immutable
class ReferralsState {
  final LoadingModel loadingStatus;
  final ReferralsModel referral;

  ReferralsState({
    this.loadingStatus,
    this.referral,
  });

  ReferralsState copyWith({
    LoadingModel loadingStatus,
    ReferralsModel referral,
  }) {
    return ReferralsState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      referral: referral ?? this.referral,
    );
  }

  factory ReferralsState.initial() {
    return ReferralsState(
      loadingStatus: LoadingModel.initial(),
      referral: ReferralsModel(),
    );
  }
}
