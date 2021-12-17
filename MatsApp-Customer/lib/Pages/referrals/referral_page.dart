import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Pages/_partials/app_loading_spinner.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/referrals/referrals_view_model.dart';
import 'package:matsapp/utilities/CommonDialoges.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/app_number_formatter.dart';
import 'package:matsapp/utilities/size_config.dart';

class ReferralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Refer & Earn"),
          actions: [],
        ),
        body: StoreConnector<AppState, ReferralsViewModel>(
            onInitialBuild: (viewModel) {
              viewModel.getReferralDetails();
            },
            converter: (store) => ReferralsViewModel.fromStore(store),
            onDispose: (store) {
              store.dispatch(OnClearAction(type: "Referrals"));
            },
            onWillChange: (old, viewModel) async {},
            onDidChange: (old, viewModel) async {
              if (old.isLoading && viewModel.hasError) {
                final snackBar =
                    SnackBar(content: Text(viewModel.loadingError ?? ""));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, viewModel) {
              if (viewModel.isLoading) return AppLoadingSpinner(size: 64);

              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _TotalEarnings(
                        totalEarnings: viewModel.earnedAmount,
                        totalReferences: viewModel.totalReference,
                      ),
                      TextButton(
                        onPressed: () {
                          viewModel.hasClaimAllow
                              ? Navigator.pushNamed(context, "/claimSelection")
                              : CommonDialoges().ClaimAllowedDialog(
                                  context, viewModel.earnedAmount);
                          //GeneralTools().createSnackBarCommon("", context)
                          //"/storeproductpage");
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9.0),
                                color: AppColors.success_color),
                            child: Text('Claim',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.white,
                                    letterSpacing: 1.14,
                                    fontWeight: FontWeight.normal))),
                      ),
                      if (viewModel.hasReference)
                        _Reference(
                          onReference: viewModel.onCouponRefer,
                        ),
                      _Invite(
                        referralAmount: viewModel.referenceAmount,
                        referralCode: viewModel.myReferralCode,
                        onInvite: () {
                          viewModel.invite();
                        },
                        onCopyCode: () =>
                            viewModel.copyToClipBoard().then((value) => {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Referal code copied to clipboard ")))
                                }),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

class _Invite extends StatelessWidget {
  final String referralCode;
  final String referralAmount;
  final VoidCallback onCopyCode;
  final VoidCallback onInvite;

  const _Invite({
    Key key,
    this.referralCode,
    this.onCopyCode,
    this.referralAmount,
    this.onInvite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
          SizedBox(height: 0),
          Image.asset(
            'assets/images/referral_bg.png',
            height: SizeConfig.heightMultiplier * 40,
          ),
          SizedBox(height: 0),
          Text.rich(
            TextSpan(
              style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xff6d6b6b),
                  letterSpacing: 0.96),
              children: [
                TextSpan(
                  text: 'Invite your friends and get ',
                ),
                TextSpan(
                  text: '\n',
                  style: TextStyle(
                    fontSize: 27,
                    color: AppColors.kSecondaryDarkColor,
                    letterSpacing: 1.6,
                  ),
                ),
                TextSpan(
                  text: '$referralAmount',
                  style: TextStyle(
                    fontSize: 27,
                    color: AppColors.kSecondaryDarkColor,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: ' each',
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 18),
          InkWell(
            onTap: onCopyCode,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: DottedBorder(
                dashPattern: [6, 4, 6],
                padding: EdgeInsets.symmetric(vertical: 8),
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '$referralCode',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        letterSpacing: 1.58,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Icon(
                      Icons.copy,
                      color: Colors.grey,
                      size: 24,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 14),
          TextButton(
            onPressed: onInvite,
            child: Container(
                width: MediaQuery.of(context).size.width / 4,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.0),
                  color: const Color(0xff869ef8),
                ),
                child: Text('Invite',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                        letterSpacing: 1.14,
                        fontWeight: FontWeight.w700))),
          )
        ]));
  }
}

class _Reference extends StatelessWidget {
  final Function(String) onReference;

  const _Reference({Key key, this.onReference}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.symmetric(horizontal: 38, vertical: 14),
        // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        // alignment: Alignment.center,
        // decoration: BoxDecoration(
        //border: Border.all(width: 1.0, color: AppColors.lightGreyWhite),
        //   ),
        //   child: TextFormField(
        //     textInputAction: TextInputAction.done,
        //     onFieldSubmitted: (val) {
        //       if (val?.isNotEmpty ?? false) {
        //         onReference(val);
        //       } else {
        //         ScaffoldMessenger.of(context).showSnackBar(
        //             SnackBar(content: Text("Please enter a valid reference")));
        //       }
        //     },
        //     style: TextStyle(
        //         fontSize: 16,
        //         color: AppColors.kPrimaryColor,
        //         letterSpacing: 1.72,
        //         fontWeight: FontWeight.w700),
        //     textAlign: TextAlign.center,
        //     decoration: InputDecoration(
        //         hintText: 'Enter your friends Referral code',
        //         hintStyle: TextStyle(
        //           fontSize: 14,
        //           color: const Color(0xff979797),
        //           letterSpacing: 0.72,
        //         ),
        //         border: InputBorder.none),
        //   ),
        );
  }
}

class _TotalEarnings extends StatelessWidget {
  final double totalEarnings;

  final int totalReferences;

  const _TotalEarnings(
      {Key key, this.totalEarnings = 0.0, this.totalReferences})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            left: SizeConfig.widthMultiplier * 13,
            right: SizeConfig.widthMultiplier * 13,
            top: 30,
            bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27.0),
          color: const Color(0xffffffff),
          //border: Border.all(width: 1.0, color: AppColors.lightGreyWhite),
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(children: [
          SizedBox(height: 14),
          Text(
            'You have earned ',
            style: TextStyle(
                fontSize: 20,
                color: const Color(0xff6d6b6b),
                letterSpacing: 1.4),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SvgPicture.asset(AppVectors.dolor_svg),
            Text(' Rs ${AppNumberFormat(totalEarnings).currency}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: const Color(0xff6d6b6b),
                  letterSpacing: 2.2,
                  fontWeight: FontWeight.w700,
                ))
          ]),
          SizedBox(height: 14),
          Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(27.0),
                    bottomLeft: Radius.circular(27.0)),
                color: AppColors.kPrimaryColor,
              ),
              child: Text('Total Referrals  -  ${totalReferences ?? 0}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  )))
        ]));
  }
}
