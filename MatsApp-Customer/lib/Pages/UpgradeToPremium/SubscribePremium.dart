import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/Modeles/SubscriptionDetailsModel.dart';
import 'package:matsapp/Network/SubscribePremiumRepo.dart';
import 'package:matsapp/Network/SubscriptionDeatailsRepo.dart';
import 'package:matsapp/Pages/PaymentPage/paymentPagePremium.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/ExclusiveDeals/TimerWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscribePremium extends StatefulWidget {
  const SubscribePremium({Key key}) : super(key: key);

  @override
  _SubscribePremiumState createState() => _SubscribePremiumState();
}

class _SubscribePremiumState extends State<SubscribePremium> {
  SubscriptionDetailsModel subscribePremiumModel;

  int orerId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      backgroundColor: Colors.white,
      title: Text("Upgrade to Premium",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.25,
              fontSize: 18,
              color: Colors.blueGrey)),
      centerTitle: true,
      leading: InkWell(
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar,
        body: FutureBuilder(
            future: fetchPremiumDetails(),
            builder: (BuildContext context,
                AsyncSnapshot<SubscriptionDetailsModel> snapshot) {
              if (snapshot.hasData) {
                subscribePremiumModel = snapshot.data;
                return Container(
                  color: Colors.white,
                  width: SizeConfig.screenwidth,
                  child: SingleChildScrollView(
                    child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: SizeConfig.screenwidth,
                              // height: SizeConfig.heightMultiplier * 85,
                              child: Stack(children: <Widget>[
                                // Image.asset('assets/images/discount.png'),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(left: 8.0, top: 16),
                                //   child: Text(
                                //     "Special\nOffer",
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //         color: Colors.white,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.heightMultiplier * 1),
                                    alignment: Alignment.topCenter,
                                    child: SvgPicture.asset(
                                      'assets/vectors/img_premium.svg',
                                      height: SizeConfig.heightMultiplier * 25,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 3,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Be ',
                                      style: TextStyle(
                                          color: AppColors.kSecondaryDarkColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize:
                                              SizeConfig.heightMultiplier *
                                                  4.8),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Premium',
                                            style: TextStyle(
                                                color: AppColors
                                                    .kSecondaryDarkColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeConfig
                                                        .heightMultiplier *
                                                    4.8)),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Be ',
                                      style: TextStyle(
                                          color: AppColors.kSecondaryDarkColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize:
                                              SizeConfig.heightMultiplier *
                                                  4.8),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Different',
                                            style: TextStyle(
                                                color: AppColors
                                                    .kSecondaryDarkColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeConfig
                                                        .heightMultiplier *
                                                    4.8)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 2.5,
                                  ),
                                  Container(
                                    width: SizeConfig.widthMultiplier * 45,
                                    child: Text(
                                      "By becoming premium you will be able to",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              SizeConfig.heightMultiplier * 2),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    width: SizeConfig.screenwidth,
                                    child: Card(
                                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0,
                                          SizeConfig.heightMultiplier * 3.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      elevation: 1,
                                      child: Container(
                                        width: SizeConfig.screenwidth,
                                        padding: EdgeInsets.only(
                                            top: SizeConfig.widthMultiplier *
                                                7.5,
                                            bottom: SizeConfig.widthMultiplier *
                                                7.5,
                                            left:
                                                SizeConfig.widthMultiplier * 5,
                                            right:
                                                SizeConfig.widthMultiplier * 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // Container(
                                            //   padding: EdgeInsets.only(
                                            //     top: 5,
                                            //   ),
                                            //   width:
                                            //       SizeConfig.widthMultiplier *
                                            //           10,
                                            //   alignment: Alignment.topLeft,
                                            //   height:
                                            //       SizeConfig.heightMultiplier *
                                            //           5,
                                            //   child: SvgPicture.asset(
                                            //     'assets/vectors/ic_check.svg',
                                            //     height: SizeConfig
                                            //             .heightMultiplier *
                                            //         4,
                                            //     alignment: Alignment.topLeft,
                                            //   ),
                                            // ),
                                            Container(
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      80,
                                              child: Text(
                                                "${subscribePremiumModel.result.pkgDescription.replaceAll("*", '\u2713').replaceAll('?', '\n\n')}",
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: AppColors
                                                        .lightGreyWhite,
                                                    fontSize: SizeConfig
                                                            .heightMultiplier *
                                                        2.25),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ])
                              ])),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: subscribePremiumModel.result.pkgPremiumFlag
                                    .contains("false")
                                ? Container(
                                    height: SizeConfig.heightMultiplier * 20,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/rupee.png',
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    3,
                                              ),
                                              Text(
                                                "${subscribePremiumModel.result.pkgAmount.toString()} only",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: SizeConfig
                                                            .heightMultiplier *
                                                        3.8),
                                              ),
                                            ]),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: kPrimaryColor,
                                                fixedSize: Size.fromWidth(
                                                    SizeConfig.widthMultiplier *
                                                        50),
                                                padding: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18))),
                                            child: Text(
                                              "Upgrade",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: SizeConfig
                                                          .heightMultiplier *
                                                      2.7,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              subscribePremium(
                                                      subscribePremiumModel
                                                          .result.pkgId,
                                                      subscribePremiumModel
                                                          .result.pkgAmount)
                                                  .then((value) => {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => PayMentPagePremium(
                                                                    value
                                                                        .result,
                                                                    subscribePremiumModel
                                                                        .result
                                                                        .pkgId,
                                                                    subscribePremiumModel
                                                                        .result
                                                                        .pkgAmount))),
                                                      });
                                            }),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Image.asset(
                                            //   'assets/images/rupee.png',
                                            //   height:
                                            //       SizeConfig.heightMultiplier * 3,
                                            // ),
                                            RichText(
                                              text: TextSpan(
                                                // text:
                                                //     "${subscribePremiumModel.result.pkgAmount.toString()}",
                                                // style: TextStyle(
                                                //     color: Colors.black,
                                                //     fontWeight: FontWeight.bold,
                                                //     fontSize: SizeConfig
                                                //             .heightMultiplier *
                                                //         3.8),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Enjoy premium offers for ',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .heightMultiplier *
                                                              2)),
                                                  TextSpan(
                                                      text:
                                                          "${subscribePremiumModel.result.pkgPeriod}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .heightMultiplier *
                                                              3)),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    child: Column(children: [
                                      Text(
                                        "You are a Premium User now",
                                        style: TextStyle(
                                            color: kAccentColor,
                                            fontSize:
                                                SizeConfig.textMultiplier * 3.5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Offer ",
                                              style: TextStyle(
                                                  color: AppColors
                                                      .kSecondaryDarkColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: SizeConfig
                                                          .heightMultiplier *
                                                      1.6),
                                            ),
                                            TimerWidget(
                                                subscribePremiumModel
                                                    .result.endDate,
                                                subscribePremiumModel
                                                    .result.endTime)
                                          ]),
                                    ]),
                                  ),
                          ),
                        ]),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

Future<void> prefsetPremiumUser(bool premiumUser) async {
  // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  await prefs.setBool("PremiumUser", premiumUser);
}
