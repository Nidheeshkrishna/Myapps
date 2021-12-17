import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Pages/_partials/couponcancelDialog.dart';
import 'package:matsapp/Pages/_partials/tc_dialog.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DetailesDialog.dart';
import 'package:matsapp/utilities/app_number_formatter.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/Couponbackground1.dart';

class CouponDialogBground extends StatelessWidget {
  final CouponModel coupon;
  final Color overlayColor;
  final String coupontype;

  const CouponDialogBground(
      {Key key, this.coupon, this.overlayColor, this.coupontype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            //fit: StackFit.expand,
            children: <Widget>[
              CouponbackgroundGenerated(coupontype, "Your Discount Coupon"),
              //CouponbackgroundGenerated(coupontype, ""),
              // Couponbackground(coupon.couponType ?? 0),
              Container(
                width: screenWidth * .90,
                height: screenHeight * .20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      //width: screenWidth * .43,
                      height: screenHeight * .18,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 7,
                          //bottom: SizeConfig.heightMultiplier * 2.3
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Up to ${AppNumberFormat(coupon?.matsappDiscount).percent}%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            Text("Discount",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: screenWidth * .22,
                              height: screenHeight / 20,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.kAccentColor,
                                    onPrimary: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: BorderSide(color: Colors.white)),
                                  ),
                                  child: Row(
                                    children: [
                                      new Text(
                                        'Details',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  onPressed: couponcancelDialog(context,
                                      coupon?.termsAndConditions, coupon)

                                  // Dialoges().detaiesDialogSuccess(
                                  //     context, coupon?.termsAndConditions);

                                  ),
                            )

                            // Expanded(
                            //   //width: screenWidth * .32,
                            //   //height: screenHeight / 18,
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Expanded(
                            //         //flex: 8,
                            //         child: Text(
                            //             "Until\r${coupon?.couponExpiryDate ?? 0}",
                            //             style: TextStyle(
                            //               fontSize: 1.9 * SizeConfig.textMultiplier,
                            //               fontWeight: FontWeight.w600,
                            //               color: Colors.white,
                            //             )),
                            //       ),
                            //       TextButton(
                            //           style: TextButton.styleFrom(
                            //               primary: AppColors.info_color),
                            //           onPressed: showTermsAndConditionsDialog(
                            //               context, coupon?.termsAndConditions),
                            //           child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               children: <Widget>[
                            //                 Text(
                            //                   'Terms & Conditions',
                            //                   style: TextStyle(
                            //                       fontSize: 4.5 *
                            //                           SizeConfig.widthMultiplier,
                            //                       fontWeight: FontWeight.w600,
                            //                       decoration:
                            //                           TextDecoration.underline,
                            //                       color: Colors.blueAccent),
                            //                   textAlign: TextAlign.left,
                            //                 ),
                            //                 Icon(Icons.chevron_right,
                            //                     size: 17, color: Colors.blueAccent),
                            //                 Icon(Icons.chevron_right,
                            //                     size: 17, color: Colors.blueAccent)
                            //               ])),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.28),
                        image: DecorationImage(
                          image: NetworkImage(coupon?.logoUrl ?? ""),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(width: 1.0, color: Colors.white),
                      ),
                      // child: Placeholder(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
