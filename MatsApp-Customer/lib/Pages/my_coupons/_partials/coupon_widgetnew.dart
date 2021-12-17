import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/utilities/app_number_formatter.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/Couponbackground1.dart';

class CouponWidgetNew extends StatelessWidget {
  final CouponModel coupon;
  final Color overlayColor;
  final String coupontype;

  const CouponWidgetNew(
      {Key key, this.coupon, this.overlayColor, this.coupontype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * .25,
      width: screenWidth,
      child: Stack(
        //fit: StackFit.expand,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child:
                CouponbackgroundGenerated(coupontype, "Your Discount Coupon"),
          ),
          // Couponbackground(coupon.couponType ?? 0),

          Center(
            child: Container(
              width: screenWidth,
              height: screenHeight * .30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: screenWidth * .50,
                    height: screenHeight * .15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Up to\r${AppNumberFormat(coupon?.matsappDiscount).percent}%',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          
                            fontSize: SizeConfig.blockSizeHorizontal * 6,
                          ),
                        ),

                        Text("Discount",
                            style: TextStyle(
                                letterSpacing: .75,
                                fontSize: SizeConfig.blockSizeHorizontal * 6,
                                fontWeight: FontWeight.bold,
                               
                                color: Colors.white)),
                        SizedBox(
                          height: 8,
                        ),
                        // Container(
                        //   alignment: Alignment.center,
                        //   width: SizeConfig.widthMultiplier * 18,
                        //   height: SizeConfig.heightMultiplier * 4.5,
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       primary: AppColors.kAccentColor,
                        //       padding: EdgeInsets.all(2),
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(
                        //               SizeConfig.widthMultiplier)),
                        //       side: BorderSide(
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         new Text(
                        //           "Details",
                        //           style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: SizeConfig.widthMultiplier * 2.5,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     onPressed: () {
                        //       Dialoges().detaiesDialogSuccess(
                        //           context, coupon?.termsAndConditions);
                        //     },
                        //   ),
                        // )

                        // Container(
                        //   width: screenWidth * .55,
                        //   height: screenHeight / 30,
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     // mainAxisAlignment:
                        //     //     MainAxisAlignment.center,
                        //     children: [
                        //       Text("Until\r${coupon?.couponExpiryDate ?? 0}",
                        //           style: TextStyle(
                        //             fontSize: 12,
                        //             fontWeight: FontWeight.w500,
                        //             color: Colors.white,
                        //           )),
                        //       SizedBox(width: 8),
                        //       coupontype.contains("Free")
                        //           ? Container(
                        //               // width: 50,
                        //               // height: 30,
                        //               child: ElevatedButton(
                        //                 style: ElevatedButton.styleFrom(
                        //                   primary: AppColors.freecoupon_color,
                        //                   onPrimary: Colors.transparent,
                        //                   shape: RoundedRectangleBorder(
                        //                       borderRadius:
                        //                           BorderRadius.circular(8.0),
                        //                       side: BorderSide(
                        //                           color: Colors.white)),
                        //                 ),
                        //                 child: Row(
                        //                   children: [
                        //                     new Text(
                        //                       'Details',
                        //                       style: TextStyle(
                        //                           color: Colors.white,
                        //                           fontSize: 12),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 onPressed: () {
                        //                   Dialoges().detaiesDialogSuccess(
                        //                       context,
                        //                       coupon?.termsAndConditions);
                        //                 },
                        //               ),
                        //             )
                        //           : Container(
                        //               child: ElevatedButton(
                        //                 style: ElevatedButton.styleFrom(
                        //                   primary: AppColors.kAccentColor,
                        //                   onPrimary: Colors.transparent,
                        //                   shape: RoundedRectangleBorder(
                        //                       borderRadius:
                        //                           BorderRadius.circular(8.0),
                        //                       side: BorderSide(
                        //                           color: Colors.white)),
                        //                 ),
                        //                 child: Row(
                        //                   children: [
                        //                     new Text(
                        //                       'Details',
                        //                       style: TextStyle(
                        //                           color: Colors.white,
                        //                           fontSize: 12),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 onPressed: () {
                        //                   Dialoges().detaiesDialogSuccess(
                        //                       context,
                        //                       coupon?.termsAndConditions);
                        //                 },
                        //               ),
                        //             )
                        //     ],
                        //   ),
                        // ),
                      ],
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
