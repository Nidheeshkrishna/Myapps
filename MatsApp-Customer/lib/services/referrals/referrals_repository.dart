import 'package:matsapp/Modeles/referrals/referrals_model.dart';
import 'package:matsapp/services/app_exceptions.dart';

import '../../Modeles/coupon_generate/result_model.dart';
import '../base_service.dart';

class ReferralsRepository extends BaseService {
  static ReferralsRepository _instance = ReferralsRepository._();

  ReferralsRepository._() : super();

  factory ReferralsRepository() {
    return _instance;
  }

  Future<void> fetchReferralDetails({
    onSuccess<ReferralsModel> onSuccess,
    onFailure failure,
  }) async {
    int userId = await getUserId();
    var params = {"UserID": userId};
    getService(
        service: "getRefferalInfo",
        params: params,
        onException: failure,
        onSuccess: (response) {
          ReferralsModel referral = ReferralsModel.fromJson(response["result"]);
          onSuccess(referral);
        });
  }

  Future<void> applyReferral({
    String code,
    onSuccess<ResultModel> onSuccess,
    onFailure failure,
  }) async {
    int userId = await getUserId();
    var params = {"UserID": userId, "referralCode": code};
    getService(
        service: "SaveReferralCode",
        params: params,
        onException: failure,
        onSuccess: (response) {
          ResultModel referral = ResultModel.fromJson(response["result"]);
          if (referral.result?.contains("Invalid") ?? true)
            failure(AppException("Invalid Referral"));
          else
            onSuccess(referral);
        });
  }
}
